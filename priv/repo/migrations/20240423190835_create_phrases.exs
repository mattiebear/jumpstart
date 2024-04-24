defmodule Jumpstart.Repo.Migrations.CreatePhrases do
  use Ecto.Migration

  def change do
    create table(:phrases) do
      add :key, :string, null: false
      add :notes, :string
      add :status, :integer, default: 1

      add :namespace_id, references(:namespaces, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:phrases, [:namespace_id])
    create unique_index(:phrases, [:key, :namespace_id])
  end
end
