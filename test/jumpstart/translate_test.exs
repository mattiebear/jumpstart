defmodule Jumpstart.TranslateTest do
  use Jumpstart.DataCase

  alias Jumpstart.Translate

  describe "translate_settings" do
    alias Jumpstart.Translate.TranslateSettings

    import Jumpstart.TranslateFixtures

    @invalid_attrs %{}

    test "list_translate_settings/0 returns all translate_settings" do
      translate_settings = translate_settings_fixture()
      assert Translate.list_translate_settings() == [translate_settings]
    end

    test "get_translate_settings!/1 returns the translate_settings with given id" do
      translate_settings = translate_settings_fixture()
      assert Translate.get_translate_settings!(translate_settings.id) == translate_settings
    end

    test "create_translate_settings/1 with valid data creates a translate_settings" do
      valid_attrs = %{}

      assert {:ok, %TranslateSettings{} = translate_settings} = Translate.create_translate_settings(valid_attrs)
    end

    test "create_translate_settings/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Translate.create_translate_settings(@invalid_attrs)
    end

    test "update_translate_settings/2 with valid data updates the translate_settings" do
      translate_settings = translate_settings_fixture()
      update_attrs = %{}

      assert {:ok, %TranslateSettings{} = translate_settings} = Translate.update_translate_settings(translate_settings, update_attrs)
    end

    test "update_translate_settings/2 with invalid data returns error changeset" do
      translate_settings = translate_settings_fixture()
      assert {:error, %Ecto.Changeset{}} = Translate.update_translate_settings(translate_settings, @invalid_attrs)
      assert translate_settings == Translate.get_translate_settings!(translate_settings.id)
    end

    test "delete_translate_settings/1 deletes the translate_settings" do
      translate_settings = translate_settings_fixture()
      assert {:ok, %TranslateSettings{}} = Translate.delete_translate_settings(translate_settings)
      assert_raise Ecto.NoResultsError, fn -> Translate.get_translate_settings!(translate_settings.id) end
    end

    test "change_translate_settings/1 returns a translate_settings changeset" do
      translate_settings = translate_settings_fixture()
      assert %Ecto.Changeset{} = Translate.change_translate_settings(translate_settings)
    end
  end
end
