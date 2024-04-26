defmodule Jumpstart.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :name, :string

    belongs_to :account, Jumpstart.Accounts.Account

    has_many :locales, Jumpstart.Translate.Locale

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name])
    |> cast_assoc(:locales, with: &Jumpstart.Translate.Locale.changeset/2)
    |> validate_required([:name])
    |> assoc_constraint(:account)
  end
end
