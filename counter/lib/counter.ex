defmodule Counter do
  def new(input) do
    %{count: String.to_integer(input)}
  end

  def add(%{count: count} = acc, element) do
    %{acc | count: count + element}
  end

  def show(%{count: count}) do
    count
  end
end
