defmodule Jumpstart.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jumpstart.{Accounts, Projects}

  schema "accounts" do
    field :name, :string

    has_many :projects, Projects.Project
    has_many :users, Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
