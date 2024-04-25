defmodule Jumpstart.Translate.Phrase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phrases" do
    field :key, :string
    field :notes, :string
    field :status, Ecto.Enum, values: [active: 1, inactive: 2]

    belongs_to :namespace, Jumpstart.Translate.Namespace

    has_many :translations, Jumpstart.Translate.Translation

    timestamps(type: :utc_datetime)
  end

  def changeset(phrase, attrs) do
    phrase
    |> cast(attrs, [:key, :notes, :status])
    |> validate_required([:key, :status])
    |> unique_constraint([:key, :namespace_id])
    |> cast_assoc(:translations, with: &Jumpstart.Translate.Translation.changeset/2)
  end
end
