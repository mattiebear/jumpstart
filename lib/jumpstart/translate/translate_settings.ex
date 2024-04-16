defmodule Jumpstart.Translate.TranslateSettings do
  use Ecto.Schema
  import Ecto.Changeset

  schema "translate_settings" do
    field :source_locale, :string

    belongs_to :account, Jumpstart.Accounts.Account

    embeds_many :locales, Jumpstart.Translate.Locale, on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(translate_settings, attrs) do
    translate_settings
    |> cast(attrs, [])
    |> validate_required([])
  end
end
