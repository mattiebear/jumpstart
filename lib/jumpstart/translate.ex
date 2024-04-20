defmodule Jumpstart.Translate do
  @moduledoc """
  The Translate context.
  """

  import Ecto.Query, warn: false

  alias Jumpstart.Repo
  alias Jumpstart.Translate.Locale

  def list_locales_for_project(project_id) do
    from(l in Locale, where: l.project_id == ^project_id) |> Repo.all()
  end

  def create_locale_on_project(project_id, attrs) do
    %Locale{project_id: project_id}
    |> change_locale(attrs)
    |> Repo.insert()
  end

  def change_locale(%Locale{} = locale, attrs \\ %{}) do
    Locale.changeset(locale, attrs)
  end
end
