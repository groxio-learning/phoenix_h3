defmodule Worbee.Game.Core do
  defstruct guesses: [], answer: nil

  # construct
  def init(%{
        answer: answer,
        guesses: guesses
      }) do
    %__MODULE__{
      answer: answer,
      guesses: guesses
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

  def compute_guess(%__MODULE__{answer: answer}, guess) do
    guess_graphemes = String.graphemes(guess)
    answer_graphemes = String.graphemes(answer)

    wrongs = guess_graphemes -- answer_graphemes

    compute_greens(guess_graphemes, answer_graphemes)
    |> compute_grays(wrongs)
    |> compute_yellows()
    |> convert_keys_to_atoms()
  end

  def compute_latest_guess(%__MODULE__{guesses: []}) do
    []
  end

  def compute_latest_guess(%{guesses: [latest_guess | _]} = game) do
    compute_guess(game, latest_guess)
  end

  defp compute_greens(guess_graphemes, answer_graphemes) do
    guess_graphemes
    |> Enum.zip(answer_graphemes)
    |> Enum.map(fn {g, a} ->
      if g == a do
        {g, :green}
      else
        {g, :unknown}
      end
    end)
  end

  defp compute_grays(pre_result, wrongs) do
    Enum.reduce(wrongs, Enum.reverse(pre_result), fn c, result ->
      index = Enum.find_index(result, fn x -> x == {c, :unknown} end)

      if is_nil(index) do
        result
      else
        List.replace_at(result, index, {c, :gray})
      end
    end)
    |> Enum.reverse()
  end

  defp compute_yellows(pre_result) do
    Enum.map(pre_result, fn
      {c, :unknown} -> {c, :yellow}
      x -> x
    end)
  end

  defp convert_keys_to_atoms(pre_result) do
    Enum.map(pre_result, fn {c, color} -> {String.to_atom(c), color} end)
  end
end
