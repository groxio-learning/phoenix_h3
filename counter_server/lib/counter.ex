defmodule Counter do
  def new(input) do
    String.to_integer(input)
  end

  def increment(acc) do
    acc + 1
  end

  def decrement(acc) do
    acc - 1
  end

  def show(count) do
    count
  end
end
