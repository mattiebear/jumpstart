defmodule Jumpstart.Translate.Namespace do
  use Ecto.Schema
  import Ecto.Changeset

  schema "namespaces" do
    field :name, :string

    belongs_to :project, Jumpstart.Projects.Project

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(namespace, attrs) do
    namespace
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unsafe_validate_unique([:name, :project_id], Jumpstart.Repo)
  end
end
