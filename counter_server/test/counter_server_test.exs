defmodule CounterServerTest do
  use ExUnit.Case
  doctest CounterServer

  test "greets the world" do
    assert CounterServer.hello() == :world
  end
end
