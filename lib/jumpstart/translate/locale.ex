defmodule Jumpstart.Translate.Locale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locales" do
    field :code, :string
    field :name, :string
    field :role, Ecto.Enum, values: [target: 0, source: 1]

    belongs_to :translate_settings, Jumpstart.Translate.TranslateSettings

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(locale, attrs) do
    locale
    |> cast(attrs, [:code, :name, :role])
    |> validate_required([:code, :name, :role])
  end
end
