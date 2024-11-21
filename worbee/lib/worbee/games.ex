defmodule Worbee.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Worbee.Repo

  alias Worbee.Games.UserGame

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
  def get_user_game!(id), do: Repo.get!(UserGame, id)

  @doc """
  Creates a user_game.

  ## Examples

      iex> create_user_game(%{field: value})
      {:ok, %UserGame{}}

      iex> create_user_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_game(attrs \\ %{}) do
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
end
