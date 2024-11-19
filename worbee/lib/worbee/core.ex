defmodule Worbee.Core do
  defstruct guesses: [], answer: nil

  # construct
  def init(answer) do
    %__MODULE__{
      answer: answer
    }
  end

  # reduce
  def add_guess(%__MODULE__{guesses: guesses} = current_game, guess) do
    %__MODULE__{
      current_game
      | guesses: [guess | guesses]
    }
  end

  def show_guesses(game) do
    game.guesses
  end

  def show_results(%__MODULE__{guesses: []}) do
    []
  end

  # convert
  def show_results(game) do
    [latest_guess | _rest] = game.guesses

    latest_guess
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {term, index} -> {term, char_comparison(term, index, game.answer)} end)
  end

  # :correct, :wrong, :close
  defp char_comparison(guess_char, index, answer) do
    current_char = String.at(answer, index)

    cond do
      guess_char == current_char ->
        :correct

      # Bug here
      String.contains?(answer, guess_char) ->
        :close

      true ->
        :wrong
    end
  end
end
