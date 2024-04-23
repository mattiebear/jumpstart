defmodule Jumpstart.Repo.Migrations.CreateNamespaces do
  use Ecto.Migration

  def change do
    create table(:namespaces) do
      add :name, :string
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:namespaces, [:project_id])
    create unique_index(:namespaces, [:name, :project_id])
  end
end
