defmodule Jumpstart.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jumpstart.{Accounts, Projects, Translate}

  schema "accounts" do
    field :name, :string

    has_many :projects, Projects.Project
    has_many :users, Accounts.User

    has_one :translate_settings, Translate.TranslateSettings

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
