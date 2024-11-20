defmodule Worbee.Counter do
  defstruct count: 0

  def new() do
    %__MODULE__{}
  end

  def inc(%__MODULE__{count: count} = acc) do
    %{acc | count: count + 1}
  end

  def dec(%__MODULE__{count: count} = acc) do
    %{acc | count: count - 1}
  end

  def show(%__MODULE__{count: count}) do
    count
  end
end
