defmodule CounterTest do
  use ExUnit.Case
  doctest Counter

  test "42" do
    assert Counter.new("42") == %{count: 42}
  end

  test "add 5" do
    actual = "42" |> Counter.new() |> Counter.add(5)
    assert actual == %{count: 47}
  end

  test "greets the world" do
    actual =
      "42"
      |> Counter.new()
      |> Counter.add(5)
      |> Counter.show()

    assert actual == 47
  end
end
