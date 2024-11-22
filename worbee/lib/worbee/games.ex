defmodule Worbee.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Worbee.Repo
  alias Worbee.Library
  alias Worbee.Games.UserGame
  alias Worbee.Games.Guess
  alias Worbee.Game.Core

  @doc """
  Returns the list of user_games.

  ## Examples

      iex> list_user_games()
      [%UserGame{}, ...]

  """
  def list_user_games do
    Repo.all(UserGame)
  end

  @doc """
  Gets a single user_game.

  Raises `Ecto.NoResultsError` if the User game does not exist.

  ## Examples

      iex> get_user_game!(123)
      %UserGame{}

      iex> get_user_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_game!(id), do: Repo.get!(UserGame, id) |> Repo.preload(:guesses)

  def core!(user_game) do
    answer = user_game.answer

    guesses =
      user_game.guesses
      |> Enum.map(fn x -> x.guess end)
      |> Enum.reverse()

    Core.init(%{answer: answer, guesses: guesses})
  end

  @doc """
  Creates a user_game.

  ## Examples

      iex> create_user_game(%{field: value})
      {:ok, %UserGame{}}

      iex> create_user_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_or_get_user_game(%{mode: "random"} = attrs) do
    %UserGame{}
    |> UserGame.changeset(attrs)
    |> Repo.insert()
  end

  def create_or_get_user_game(%{mode: "daily", user_id: user_id} = attrs) do
    todays_answer = Library.get_daily_answer_by_date(Date.utc_today())

    user_game =
      from(g in UserGame,
        where: g.user_id == ^user_id,
        where: g.daily_answer_id == ^todays_answer.id
      )
      |> Repo.one()

    if user_game do
      {:ok, user_game}
    else
      create_daily_user_game(attrs)
    end
  end

  def create_daily_user_game(attrs) do
    todays_answer = Library.get_daily_answer_by_date(Date.utc_today())

    attrs =
      attrs
      |> Map.put(:answer, todays_answer.word)
      |> Map.put(:daily_answer_id, todays_answer.id)

    %UserGame{}
    |> UserGame.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_game.

  ## Examples

      iex> update_user_game(user_game, %{field: new_value})
      {:ok, %UserGame{}}

      iex> update_user_game(user_game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_game(%UserGame{} = user_game, attrs) do
    user_game
    |> UserGame.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_game.

  ## Examples

      iex> delete_user_game(user_game)
      {:ok, %UserGame{}}

      iex> delete_user_game(user_game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_game(%UserGame{} = user_game) do
    Repo.delete(user_game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_game changes.

  ## Examples

      iex> change_user_game(user_game)
      %Ecto.Changeset{data: %UserGame{}}

  """
  def change_user_game(%UserGame{} = user_game, attrs \\ %{}) do
    UserGame.changeset(user_game, attrs)
  end

  def create_guess(%Guess{} = guess, attrs) do
    guess |> Guess.changeset(attrs) |> Repo.insert()
  end

  def add_guess(user_game_id, game, guess) do
    case create_guess(%Guess{}, %{
           guess: guess,
           user_game_id: user_game_id
         }) do
      {:ok, _guess} ->
        game = Core.add_guess(game, guess)

        broadcast_guess(game, user_game_id)

        {:ok, game}

      error ->
        error
    end
  end

  defdelegate show_guesses(game), to: Core

  defp broadcast_guess(game, id) do
    Phoenix.PubSub.broadcast(Worbee.PubSub, topic("all"), {game, id})
  end

  defp topic(token), do: "game/#{token}"
  # subscribe to a topic
  # broadcasts to a topic
end
