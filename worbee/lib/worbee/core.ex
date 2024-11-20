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

    guess_graphemes
    |> Enum.zip(answer_graphemes)
    |> Enum.map(fn
      {g, a} when g == a ->
        {String.to_atom(g), :green}

      {g, _a} ->
        {String.to_atom(g),
         if g in wrongs do
           :gray
         else
           :yellow
         end}
    end)
  end
end
