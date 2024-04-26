defmodule Jumpstart.Translate.Phrase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phrases" do
    field :key, :string
    field :notes, :string
    field :status, Ecto.Enum, values: [active: 1, inactive: 2], default: :active

    belongs_to :namespace, Jumpstart.Translate.Namespace

    has_many :translations, Jumpstart.Translate.Translation

    timestamps(type: :utc_datetime)
  end

  def changeset(phrase, attrs) do
    phrase
    |> cast(attrs, [:key, :notes, :status])
    |> validate_required([:key, :status])
    |> validate_format(:key, ~r/^[a-zA-Z0-9_.\-]+$/,
      message: "can only contain letters, numbers, underscores, and dashes separated by periods"
    )
    |> unique_constraint([:key, :namespace_id])
    |> cast_assoc(:translations, with: &Jumpstart.Translate.Translation.changeset/2)
    |> assoc_constraint(:namespace)
  end

  def source(phrase) do
    # TODO: Maybe preload here or pass in the source locale id
    Enum.find(phrase.translations, & &1.locale.is_source)
  end
end
