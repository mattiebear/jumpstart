defmodule Jumpstart.Repo.Migrations.CreateTranslateSettings do
  use Ecto.Migration

  def change do
    create table(:translate_settings) do
      add :account_id, references(:accounts, on_delete: :nothing)

      add :locales, :map, default: %{}
      add :source_locale, :string

      timestamps(type: :utc_datetime)
    end

    create index(:translate_settings, [:account_id])
  end
end
