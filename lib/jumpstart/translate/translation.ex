defmodule Jumpstart.Translate.Translation do
  import Ecto.Changeset

  use Ecto.Schema

  schema "translations" do
    field :value, :string

    belongs_to :locale, Jumpstart.Translate.Locale
    belongs_to :phrase, Jumpstart.Translate.Phrase

    timestamps(type: :utc_datetime)
  end

  def changeset(translation, attrs) do
    translation
    |> cast(attrs, [:value])
    |> unique_constraint([:locale_id, :phrase_id])
  end
end
