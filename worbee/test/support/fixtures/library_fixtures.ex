defmodule Worbee.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Worbee.Library` context.
  """

  @doc """
  Generate a daily_answer.
  """
  def daily_answer_fixture(attrs \\ %{}) do
    {:ok, daily_answer} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-11-19],
        word: "some word"
      })
      |> Worbee.Library.create_daily_answer()

    daily_answer
  end
end
