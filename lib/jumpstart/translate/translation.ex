defmodule Jumpstart.Translate.Translation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "translations" do
    field :value, :string

    belongs_to :locale, Jumpstart.Translate.Locale
    belongs_to :phrase, Jumpstart.Translate.Phrase

    timestamps(type: :utc_datetime)
  end

  def changeset(translation, attrs) do
    translation
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
