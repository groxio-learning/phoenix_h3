defmodule HerlpTest do
  use ExUnit.Case
  doctest Herlp

  test "greets the world" do
    assert Herlp.hello() == :world
  end
end
