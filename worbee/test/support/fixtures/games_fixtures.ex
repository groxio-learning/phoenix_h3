defmodule Worbee.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Worbee.Games` context.
  """

  @doc """
  Generate a user_game.
  """
  def user_game_fixture(attrs \\ %{}) do
    {:ok, user_game} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        mode: :daily
      })
      |> Worbee.Games.create_user_game()

    user_game
  end
end
