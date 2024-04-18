defmodule Jumpstart.Repo.Migrations.CreateLocales do
  use Ecto.Migration

  def change do
    create table(:locales) do
      add :code, :string, null: false
      add :name, :string, null: false
      add :source, :boolean, default: false
      add :status, :integer, default: 1

      add :translate_settings_id, references(:translate_settings, on_delete: :delete_all),
        null: false

      timestamps(type: :utc_datetime)
    end
  end
end
