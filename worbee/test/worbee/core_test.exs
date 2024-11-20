defmodule Worbee.CoreTest do
  use WorbeeWeb.ConnCase, async: true

  alias Worbee.Game.Core

  describe "init/1" do
    test "should return a struct that represents the module with the given arg as the answer" do
      answer = "going"

      %Core{answer: ^answer} = Core.init(answer)
    end
  end

  describe "add_guess/2" do
    test "should add a guess to the guesses list" do
      guesses = ["north", "boost", "bound"]

      Enum.reduce(guesses, Core.init("going"), fn guess, game ->
        game = Core.add_guess(game, guess)
        assert guess in game.guesses
        game
      end)
    end
  end

  describe "compute_latest_guess/1" do
    test "should return an empty list if there are no guesses" do
      Core.init("going")
      |> Core.compute_latest_guess()
      |> assert_equal([])
    end

    test "should return the correct keyword list when the guess is correct there are correct characters and wrong characters" do
      Core.init("going")
      |> Core.add_guess("going")
      |> Core.compute_latest_guess()
      |> assert_equal(g: :green, o: :green, i: :green, n: :green, g: :green)
    end

    test "should return the correct keyword list when the guess has bad positioned characters" do
      game = Core.init("going")

      game
      |> Core.add_guess("north")
      |> Core.compute_latest_guess()
      |> assert_equal(n: :yellow, o: :green, r: :gray, t: :gray, h: :gray)

      game
      |> Core.add_guess("niche")
      |> Core.compute_latest_guess()
      |> assert_equal(n: :yellow, i: :yellow, c: :gray, h: :gray, e: :gray)

      game
      |> Core.add_guess("boost")
      |> Core.compute_latest_guess()
      |> assert_equal(b: :gray, o: :green, o: :gray, s: :gray, t: :gray)

      game
      |> Core.add_guess("ggggg")
      |> Core.compute_latest_guess()
      |> assert_equal(g: :green, g: :gray, g: :gray, g: :gray, g: :green)

      game
      |> Core.add_guess("iipgg")
      |> Core.compute_latest_guess()
      |> assert_equal(i: :yellow, i: :gray, p: :gray, g: :yellow, g: :green)
    end

    test "should return the correct keyword list when the guess does not have any character of the answer" do
      Core.init("going")
      |> Core.add_guess("burst")
      |> Core.compute_latest_guess()
      |> assert_equal(b: :gray, u: :gray, r: :gray, s: :gray, t: :gray)
    end
  end

  defp assert_equal(left, right) do
    assert left == right
  end
end
