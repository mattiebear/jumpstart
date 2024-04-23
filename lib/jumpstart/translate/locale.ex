defmodule Jumpstart.Translate.Locale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locales" do
    field :code, :string
    field :name, :string
    field :is_source, :boolean, default: false
    field :status, Ecto.Enum, values: [active: 1, inactive: 2]

    belongs_to :project, Jumpstart.Projects.Project

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(locale, attrs) do
    locale
    |> cast(attrs, [:code, :name, :is_source, :status])
    |> validate_required([:code, :name, :is_source])
  end
end
