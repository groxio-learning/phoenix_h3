defmodule Worbee.Repo.Migrations.AddUserRoles do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, null: false, default: ""
    end
  end
end
