defmodule Jumpstart.Repo.Migrations.CreateTranslateSettings do
  use Ecto.Migration

  def change do
    create table(:translate_settings) do
      add :account_id, references(:accounts, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:translate_settings, [:account_id])
  end
end
