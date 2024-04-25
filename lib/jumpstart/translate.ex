defmodule Jumpstart.Translate do
  @moduledoc """
  The Translate context.
  """

  alias Ecto.Multi
  alias Jumpstart.Repo
  alias Jumpstart.Translate.{Locale, Namespace, Phrase, Translation}

  import Ecto.Query, warn: false

  def list_locales_for_project(project_id) do
    from(l in Locale, where: l.project_id == ^project_id, order_by: [asc: :name])
    |> Repo.all()
  end

  def create_locale_on_project(project_id, attrs) do
    %Locale{project_id: project_id}
    |> change_locale(attrs)
    |> Repo.insert()
  end

  def get_locale!(id) do
    Repo.get!(Locale, id)
  end

  def update_locale(%Locale{} = locale, attrs) do
    locale
    |> change_locale(attrs)
    |> Repo.update()
  end

  def change_locale(%Locale{} = locale, attrs \\ %{}) do
    Locale.changeset(locale, attrs)
  end

  def set_source_locale(locale) do
    query =
      from(l in Locale,
        where: l.project_id == ^locale.project_id and l.is_source == true
      )

    changeset = change_locale(locale, %{is_source: true})

    Multi.new()
    |> Multi.update_all(:deactivate, query, set: [is_source: false])
    |> Multi.update(:activate, changeset)
    |> Repo.transaction()
  end

  def list_namespaces_for_project(project_id) do
    from(n in Namespace, where: n.project_id == ^project_id, order_by: [asc: :name])
    |> Repo.all()
  end

  def change_namespace(%Namespace{} = namespace, attrs \\ %{}) do
    Namespace.changeset(namespace, attrs)
  end

  def update_namespace(%Namespace{} = namespace, attrs) do
    namespace
    |> change_namespace(attrs)
    |> Repo.update()
  end

  def get_namespace_by_name!(project_id, name) do
    Repo.get_by!(Namespace, project_id: project_id, name: name)
  end

  def init_phrase(namespace, locales, attrs \\ %{}) do
    %Phrase{}
    |> change_phrase(attrs)
    |> Ecto.Changeset.put_assoc(:namespace, namespace)
    |> Ecto.Changeset.put_assoc(:translations, Enum.map(locales, &init_translation/1))
  end

  def change_phrase(%Phrase{} = phrase, attrs \\ %{}) do
    Phrase.changeset(phrase, attrs)
  end

  def init_translation(locale) do
    %Translation{locale_id: locale.id}
    |> change_translation()
  end

  def change_translation(%Translation{} = translation, attrs \\ %{}) do
    Translation.changeset(translation, attrs)
  end
end
