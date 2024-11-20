defmodule Worbee.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias Worbee.Repo

  alias Worbee.Library.DailyAnswer

  @doc """
  Returns the list of daily_answers.

  ## Examples

      iex> list_daily_answers()
      [%DailyAnswer{}, ...]

  """
  def list_daily_answers do
    Repo.all(DailyAnswer)
  end

  @doc """
  Gets a single daily_answer.

  Raises `Ecto.NoResultsError` if the Daily answer does not exist.

  ## Examples

      iex> get_daily_answer!(123)
      %DailyAnswer{}

      iex> get_daily_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_answer!(id), do: Repo.get!(DailyAnswer, id)

  def get_daily_answer_by_date(date), do: Repo.get_by(DailyAnswer, date: date)

  @doc """
  Creates a daily_answer.

  ## Examples

      iex> create_daily_answer(%{field: value})
      {:ok, %DailyAnswer{}}

      iex> create_daily_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_answer(attrs \\ %{}) do
    %DailyAnswer{}
    |> DailyAnswer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_answer.

  ## Examples

      iex> update_daily_answer(daily_answer, %{field: new_value})
      {:ok, %DailyAnswer{}}

      iex> update_daily_answer(daily_answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_answer(%DailyAnswer{} = daily_answer, attrs) do
    daily_answer
    |> DailyAnswer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a daily_answer.

  ## Examples

      iex> delete_daily_answer(daily_answer)
      {:ok, %DailyAnswer{}}

      iex> delete_daily_answer(daily_answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_answer(%DailyAnswer{} = daily_answer) do
    Repo.delete(daily_answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_answer changes.

  ## Examples

      iex> change_daily_answer(daily_answer)
      %Ecto.Changeset{data: %DailyAnswer{}}

  """
  def change_daily_answer(%DailyAnswer{} = daily_answer, attrs \\ %{}) do
    DailyAnswer.changeset(daily_answer, attrs)
  end
end
