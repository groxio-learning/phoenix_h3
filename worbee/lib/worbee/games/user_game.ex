defmodule Worbee.Games.UserGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_games" do
    field(:mode, Ecto.Enum, values: [:daily, :random])
    field(:answer, :string)
    belongs_to(:user, Worbee.Accounts.User)
    has_many(:guesses, Worbee.Games.Guess)
    field(:daily_answer_id, :id)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_game, attrs) do
    user_game
    |> cast(attrs, [:mode, :answer, :user_id, :daily_answer_id])
    |> validate_required([:mode, :answer, :user_id])
  end
end
