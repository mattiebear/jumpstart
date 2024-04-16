defmodule Jumpstart.Repo.Migrations.CreateLocales do
  use Ecto.Migration

  def change do
    create table(:locales) do
      add :code, :string
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
