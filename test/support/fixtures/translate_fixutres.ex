defmodule Jumpstart.TranslateFixtures do
  alias Jumpstart.ProjectsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jumpstart.Translate` context.
  """

  @doc """
  Generate a locale.
  """
  def locale_fixture(attrs \\ %{}) do
    project = ProjectsFixtures.project_fixture()

    attrs =
      attrs
      |> Enum.into(%{
        name: "English",
        code: "en",
        is_source: true,
        status: :active
      })

    {:ok, locale} =
      Jumpstart.Translate.create_locale_on_project(project.id, attrs)

    locale
  end
end
