defmodule Jumpstart.Translate.Namespace do
  use Ecto.Schema
  import Ecto.Changeset

  schema "namespaces" do
    field :name, :string

    belongs_to :project, Jumpstart.Projects.Project

    has_many :phrases, Jumpstart.Translate.Phrase

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(namespace, attrs) do
    namespace
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint([:name, :project_id])
    |> assoc_constraint(:project)
  end
end
