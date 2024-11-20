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

  def compute_latest_guess(%__MODULE__{guesses: []}) do
    []
  end

  def compute_latest_guess(%{answer: answer, guesses: [latest_guess | _]} = _game) do
    guess_graphemes = String.graphemes(latest_guess)
    answer_graphemes = String.graphemes(answer)

    wrongs = guess_graphemes -- answer_graphemes

    result =
      guess_graphemes
      |> Enum.zip(answer_graphemes)
      |> Enum.map(fn {g, a} -> if g == a do {g, :green} else {g, nil} end end)
      |> Enum.reverse()

    Enum.reduce(wrongs, result, fn c, result ->
      index = Enum.find_index(result, fn x -> x == {c, nil} end)
      if is_nil(index) do
        result
      else
        List.replace_at(result, index, {c, :gray})
      end
    end)
    |> Enum.reverse()
    |> Enum.map(fn
      {c, nil} -> {c, :yellow}
      x -> x
    end)
    |> Enum.map(fn {c, color} -> {String.to_atom(c), color} end)
  end
end
