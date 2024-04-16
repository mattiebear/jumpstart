defmodule Jumpstart.Translate.TranslateSettings do
  use Ecto.Schema
  import Ecto.Changeset

  schema "translate_settings" do
    belongs_to :account, Jumpstart.Accounts.Account

    has_many :locales, Jumpstart.Translate.Locale

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(translate_settings, attrs) do
    translate_settings
    |> cast(attrs, [])
    |> cast_assoc(:locales, with: &Jumpstart.Translate.Locale.changeset/2)
    |> validate_required([])
  end
end
