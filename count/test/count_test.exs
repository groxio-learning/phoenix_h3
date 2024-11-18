defmodule CountTest do
  use ExUnit.Case
  doctest Count

  test "new/1 returns a struct" do
    assert %Count{count: 42} == Count.new("42")
  end

  test "add/2 adds a value to the count field in the struct" do
    assert %Count{count: 52} ==
             Count.add(
               %Count{
                 count: 42
               },
               10
             )
  end

  test "show/1 returns the count value in the struct" do
    assert 42 ==
             Count.show(%Count{
               count: 42
             })
  end

  test "It returns the count value" do
    assert 20 ==
             Count.new("10")
             |> Count.add(5)
             |> Count.add(5)
             |> Count.show()
  end
end
