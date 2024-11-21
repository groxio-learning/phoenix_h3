defmodule Worbee.GamesTest do
  use Worbee.DataCase

  alias Worbee.Games

  describe "user_games" do
    alias Worbee.Games.UserGame

    import Worbee.GamesFixtures

    @invalid_attrs %{mode: nil, answer: nil}

    test "list_user_games/0 returns all user_games" do
      user_game = user_game_fixture()
      assert Games.list_user_games() == [user_game]
    end

    test "get_user_game!/1 returns the user_game with given id" do
      user_game = user_game_fixture()
      assert Games.get_user_game!(user_game.id) == user_game
    end

    test "create_user_game/1 with valid data creates a user_game" do
      valid_attrs = %{mode: :daily, answer: "some answer"}

      assert {:ok, %UserGame{} = user_game} = Games.create_user_game(valid_attrs)
      assert user_game.mode == :daily
      assert user_game.answer == "some answer"
    end

    test "create_user_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_user_game(@invalid_attrs)
    end

    test "update_user_game/2 with valid data updates the user_game" do
      user_game = user_game_fixture()
      update_attrs = %{mode: :random, answer: "some updated answer"}

      assert {:ok, %UserGame{} = user_game} = Games.update_user_game(user_game, update_attrs)
      assert user_game.mode == :random
      assert user_game.answer == "some updated answer"
    end

    test "update_user_game/2 with invalid data returns error changeset" do
      user_game = user_game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_user_game(user_game, @invalid_attrs)
      assert user_game == Games.get_user_game!(user_game.id)
    end

    test "delete_user_game/1 deletes the user_game" do
      user_game = user_game_fixture()
      assert {:ok, %UserGame{}} = Games.delete_user_game(user_game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_user_game!(user_game.id) end
    end

    test "change_user_game/1 returns a user_game changeset" do
      user_game = user_game_fixture()
      assert %Ecto.Changeset{} = Games.change_user_game(user_game)
    end
  end
end
