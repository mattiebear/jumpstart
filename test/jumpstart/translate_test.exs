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

  describe "locales" do
    alias Jumpstart.Translate.Locale

    import Jumpstart.TranslateFixtures

    @invalid_attrs %{code: nil, name: nil}

    test "list_locales/0 returns all locales" do
      locale = locale_fixture()
      assert Translate.list_locales() == [locale]
    end

    test "get_locale!/1 returns the locale with given id" do
      locale = locale_fixture()
      assert Translate.get_locale!(locale.id) == locale
    end

    test "create_locale/1 with valid data creates a locale" do
      valid_attrs = %{code: "some code", name: "some name"}

      assert {:ok, %Locale{} = locale} = Translate.create_locale(valid_attrs)
      assert locale.code == "some code"
      assert locale.name == "some name"
    end

    test "create_locale/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Translate.create_locale(@invalid_attrs)
    end

    test "update_locale/2 with valid data updates the locale" do
      locale = locale_fixture()
      update_attrs = %{code: "some updated code", name: "some updated name"}

      assert {:ok, %Locale{} = locale} = Translate.update_locale(locale, update_attrs)
      assert locale.code == "some updated code"
      assert locale.name == "some updated name"
    end

    test "update_locale/2 with invalid data returns error changeset" do
      locale = locale_fixture()
      assert {:error, %Ecto.Changeset{}} = Translate.update_locale(locale, @invalid_attrs)
      assert locale == Translate.get_locale!(locale.id)
    end

    test "delete_locale/1 deletes the locale" do
      locale = locale_fixture()
      assert {:ok, %Locale{}} = Translate.delete_locale(locale)
      assert_raise Ecto.NoResultsError, fn -> Translate.get_locale!(locale.id) end
    end

    test "change_locale/1 returns a locale changeset" do
      locale = locale_fixture()
      assert %Ecto.Changeset{} = Translate.change_locale(locale)
    end
  end
end
