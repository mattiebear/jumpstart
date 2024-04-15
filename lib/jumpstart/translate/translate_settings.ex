defmodule Jumpstart.Translate.TranslateSettings do
  use Ecto.Schema
  import Ecto.Changeset

  schema "translate_settings" do
    belongs_to :account, Jumpstart.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(translate_settings, attrs) do
    translate_settings
    |> cast(attrs, [])
    |> validate_required([])
  end
end
