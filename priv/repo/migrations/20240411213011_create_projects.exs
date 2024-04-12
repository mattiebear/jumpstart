defmodule Jumpstart.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :account_id, references(:accounts, on_delete: :delete_all), null: false

      add :name, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:projects, [:account_id])
  end
end
