defmodule Jumpstart.TranslateFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jumpstart.Translate` context.
  """

  @doc """
  Generate a translate_settings.
  """
  def translate_settings_fixture(attrs \\ %{}) do
    {:ok, translate_settings} =
      attrs
      |> Enum.into(%{

      })
      |> Jumpstart.Translate.create_translate_settings()

    translate_settings
  end
end
