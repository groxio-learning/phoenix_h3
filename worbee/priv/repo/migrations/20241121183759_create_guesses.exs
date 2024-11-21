defmodule Worbee.Repo.Migrations.CreateGuesses do
  use Ecto.Migration

  def change do
    create table(:guesses) do
      add(:guess, :string)
      add(:user_game_id, references(:user_games, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:guesses, [:user_game_id]))
  end
end
