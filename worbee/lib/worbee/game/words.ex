defmodule Worbee.Game.Words do
  def valid?(guess) do
    read_file("wordle-Ta.txt")
    |> MapSet.new()
    |> IO.inspect()
    |> MapSet.member?(guess)
  end

  def random_answer() do
    read_file("wordle-La.txt")
    |> Enum.random()
  end

  def read_file(filename) do
    [File.cwd!(), "assets", filename]
    |> Path.join()
    |> File.read!()
    |> String.split("\n")
  end
end
