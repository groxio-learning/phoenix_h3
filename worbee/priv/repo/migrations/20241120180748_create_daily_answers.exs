defmodule Worbee.Repo.Migrations.CreateDailyAnswers do
  use Ecto.Migration

  def change do
    create table(:daily_answers) do
      add :word, :string
      add :date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
