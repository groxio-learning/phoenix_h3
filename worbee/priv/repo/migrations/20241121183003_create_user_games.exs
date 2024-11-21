defmodule Worbee.Repo.Migrations.CreateUserGames do
  use Ecto.Migration

  def change do
    create table(:user_games) do
      add(:mode, :string)
      add(:answer, :string)
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:daily_answer_id, references(:daily_answers, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:user_games, [:user_id]))
    create(index(:user_games, [:daily_answer_id]))
  end
end
