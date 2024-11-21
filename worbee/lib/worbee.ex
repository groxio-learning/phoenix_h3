defmodule Worbee do
  defmacro __using__(_) do
    quote do
      alias Worbee.Game
      alias Worbee.Game.Core
      alias Worbee.Repo
      alias Worbee.Games
      alias Worbee.Games.Guess
    end
  end
end
