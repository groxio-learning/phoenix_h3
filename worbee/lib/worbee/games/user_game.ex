defmodule Worbee.Games.UserGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_games" do
    field :mode, Ecto.Enum, values: [:daily, :random]
    field :answer, :string
    field :user_id, :id
    field :daily_answer_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_game, attrs) do
    user_game
    |> cast(attrs, [:mode, :answer])
    |> validate_required([:mode, :answer])
  end
end
