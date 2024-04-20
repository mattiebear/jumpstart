defmodule Jumpstart.TranslateFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jumpstart.Translate` context.
  """

  @doc """
  Generate a locale.
  """
  def locale_fixture(attrs \\ %{}) do
    {:ok, locale} =
      attrs
      |> Enum.into(%{
        code: "some code",
        name: "some name"
      })
      |> Jumpstart.Translate.create_locale()

    locale
  end

  @doc """
  Generate a namespace.
  """
  def namespace_fixture(attrs \\ %{}) do
    {:ok, namespace} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Jumpstart.Translate.create_namespace()

    namespace
  end
end
