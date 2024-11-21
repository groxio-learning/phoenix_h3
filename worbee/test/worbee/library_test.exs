defmodule Worbee.LibraryTest do
  use Worbee.DataCase

  alias Worbee.Library

  describe "daily_answers" do
    alias Worbee.Library.DailyAnswer

    import Worbee.LibraryFixtures

    @invalid_attrs %{date: nil, word: nil}

    test "list_daily_answers/0 returns all daily_answers" do
      daily_answer = daily_answer_fixture()
      assert Library.list_daily_answers() == [daily_answer]
    end

    test "get_daily_answer!/1 returns the daily_answer with given id" do
      daily_answer = daily_answer_fixture()
      assert Library.get_daily_answer!(daily_answer.id) == daily_answer
    end

    test "create_daily_answer/1 with valid data creates a daily_answer" do
      valid_attrs = %{date: ~D[2024-11-19], word: "some word"}

      assert {:ok, %DailyAnswer{} = daily_answer} = Library.create_daily_answer(valid_attrs)
      assert daily_answer.date == ~D[2024-11-19]
      assert daily_answer.word == "some word"
    end

    test "create_daily_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_daily_answer(@invalid_attrs)
    end

    test "update_daily_answer/2 with valid data updates the daily_answer" do
      daily_answer = daily_answer_fixture()
      update_attrs = %{date: ~D[2024-11-20], word: "some updated word"}

      assert {:ok, %DailyAnswer{} = daily_answer} =
               Library.update_daily_answer(daily_answer, update_attrs)

      assert daily_answer.date == ~D[2024-11-20]
      assert daily_answer.word == "some updated word"
    end

    test "update_daily_answer/2 with invalid data returns error changeset" do
      daily_answer = daily_answer_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Library.update_daily_answer(daily_answer, @invalid_attrs)

      assert daily_answer == Library.get_daily_answer!(daily_answer.id)
    end

    test "delete_daily_answer/1 deletes the daily_answer" do
      daily_answer = daily_answer_fixture()
      assert {:ok, %DailyAnswer{}} = Library.delete_daily_answer(daily_answer)
      assert_raise Ecto.NoResultsError, fn -> Library.get_daily_answer!(daily_answer.id) end
    end

    test "change_daily_answer/1 returns a daily_answer changeset" do
      daily_answer = daily_answer_fixture()
      assert %Ecto.Changeset{} = Library.change_daily_answer(daily_answer)
    end
  end
end
