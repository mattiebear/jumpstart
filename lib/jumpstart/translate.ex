defmodule Jumpstart.Translate do
  @moduledoc """
  The Translate context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias Jumpstart.Repo
  alias Jumpstart.Translate.Locale

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
        where: l.project_id == ^locale.project_id and l.source == true
      )

    changeset = change_locale(locale, %{source: true})

    Multi.new()
    |> Multi.update_all(:deactivate, query, set: [source: false])
    |> Multi.update(:activate, changeset)
    |> Repo.transaction()
  end
end
