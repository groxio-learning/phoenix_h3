defmodule Worbee.Game.Gamegs do
  # another key called 'finished'
  defstruct [:answer, guesses: [], results: []]

  def new(answer) do
    %__MODULE__{answer: answer}
  end

  def guess(%{guesses: guesses} = game, word) do
    %{game | guesses: [word | guesses]}
  end

  def match(%{answer: answer, guesses: [guess | _], results: results} = game) do
    result =
      String.split(guess, "", trim: true)
      |> Stream.with_index()
      |> Enum.reduce([], fn {letter, _index}, acc ->
        if String.contains?(answer, letter) do
          acc ++ [:green_or_yellow]
        else
          acc ++ [:gray]
        end
      end)

    %{game | results: results ++ result}
  end
end
