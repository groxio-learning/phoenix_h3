defmodule CounterServiceTest do
  use ExUnit.Case
  doctest CounterService

  test "greets the world" do
    assert CounterService.hello() == :world
  end
end
