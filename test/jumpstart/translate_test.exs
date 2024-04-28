defmodule Jumpstart.TranslateTest do
  use Jumpstart.DataCase

  describe "translate" do
    alias Jumpstart.Translate.{Locale}
    alias Jumpstart.{ProjectsFixtures, Translate}

    import Jumpstart.TranslateFixtures

    test "list_locales_for_project/1 returns all locales for a project" do
      project = ProjectsFixtures.project_fixture()

      locale1 = locale_on_project_fixture(project.id, %{name: "Arabic"})
      locale2 = locale_on_project_fixture(project.id, %{name: "German"})

      assert Translate.list_locales_for_project(project.id) == [locale1, locale2]
    end

    test "get_source_locale_for_project!/1 returns the source locale" do
      project = ProjectsFixtures.project_fixture()

      source_locale = locale_on_project_fixture(project.id, %{is_source: true})
      _target_locale = locale_on_project_fixture(project.id, %{is_source: false})

      assert Translate.get_source_locale_for_project!(project.id) == source_locale
    end

    test "create_locale_on_project/2 creates a locale" do
      project = ProjectsFixtures.project_fixture()

      assert {:ok, %Locale{} = locale} =
               Translate.create_locale_on_project(project.id, %{name: "English", code: "en"})

      assert locale.name == "English"
    end

    test "get_locale!/1 returns a locale" do
      locale = locale_fixture()

      assert Translate.get_locale!(locale.id) == locale
    end

    test "update_locale/2 updates a locale" do
      locale = locale_fixture()

      assert {:ok, %Locale{} = updated_locale} =
               Translate.update_locale(locale, %{name: "Spanish"})

      assert updated_locale.name == "Spanish"
    end

    test "set_source_locale/1 sets the source locale" do
      project = ProjectsFixtures.project_fixture()

      _source_locale = locale_on_project_fixture(project.id, %{is_source: true})
      target_locale = locale_on_project_fixture(project.id, %{is_source: false})

      assert {:ok, _} =
               Translate.set_source_locale(target_locale)

      assert Translate.get_source_locale_for_project!(project.id).id == target_locale.id
    end
  end
end
