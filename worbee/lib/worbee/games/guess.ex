defmodule Worbee.Games.Guess do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guesses" do
    field(:guess, :string)
    field(:user_game_id, :id)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(guess, attrs) do
    guess
    |> cast(attrs, [:guess, :user_game_id])
    |> validate_required([:guess], message: "The guess cannot be blank")
    |> validate_required([:user_game_id])
    |> validate_length(:guess, is: 5)
    |> validate_format(:guess, ~r/^[a-z]+$/)
  end
end
