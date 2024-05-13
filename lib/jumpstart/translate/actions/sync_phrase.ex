defmodule Jumpstart.Translate.Actions.SyncPhrase do
  alias Jumpstart.Translate
  alias Jumpstart.Repo
  alias Jumpstart.Projects.Project
  alias Jumpstart.Translate.{Namespace, Phrase, Translation}

  import Ecto.Query, only: [from: 2]

  def run(namespace, key, value, source_locale, target_locales) do
    query =
      from p in Phrase,
        where: p.namespace_id == ^namespace.id and p.key == ^key,
        join: t in Translation,
        on: t.phrase_id == p.id,
        preload: :translations

    case Repo.one(query) do
      nil ->
        # create a phrase with key all translations, source being set to value
        nil

      phrase ->
        nil
        # check if source translation is different
        # if it is, update source translation
        # otherwie, nothing
    end
  end
end
