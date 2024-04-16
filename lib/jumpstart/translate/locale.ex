defmodule Jumpstart.Translate.Locale do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :code, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(locale, attrs) do
    locale
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
  end
end
