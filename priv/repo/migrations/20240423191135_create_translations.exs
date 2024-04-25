defmodule Jumpstart.Repo.Migrations.CreateTranslations do
  use Ecto.Migration

  def change do
    create table(:translations) do
      add :value, :string

      add :locale_id, references(:locales, on_delete: :delete_all)
      add :phrase_id, references(:phrases, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:translations, [:locale_id])
    create unique_index(:translations, [:phrase_id, :locale_id])
  end
end
