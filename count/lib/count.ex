defmodule Count do
  defstruct count: 42

  def new(value) do
    %__MODULE__{
      count: String.to_integer(value)
    }
  end

  def add(%{count: count}, value) do
    %__MODULE__{
      count: count + value
    }
  end

  def show(%{count: count}) do
    count
  end
end
