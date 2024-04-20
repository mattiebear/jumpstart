defmodule Jumpstart.TranslateTest do
  use Jumpstart.DataCase

  alias Jumpstart.Translate

  describe "locales" do
    alias Jumpstart.Translate.Locale

    import Jumpstart.TranslateFixtures

    @invalid_attrs %{code: nil, name: nil}

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

  describe "namespaces" do
    alias Jumpstart.Translate.Namespace

    import Jumpstart.TranslateFixtures

    @invalid_attrs %{name: nil}

    test "list_namespaces/0 returns all namespaces" do
      namespace = namespace_fixture()
      assert Translate.list_namespaces() == [namespace]
    end

    test "get_namespace!/1 returns the namespace with given id" do
      namespace = namespace_fixture()
      assert Translate.get_namespace!(namespace.id) == namespace
    end

    test "create_namespace/1 with valid data creates a namespace" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Namespace{} = namespace} = Translate.create_namespace(valid_attrs)
      assert namespace.name == "some name"
    end

    test "create_namespace/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Translate.create_namespace(@invalid_attrs)
    end

    test "update_namespace/2 with valid data updates the namespace" do
      namespace = namespace_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Namespace{} = namespace} = Translate.update_namespace(namespace, update_attrs)
      assert namespace.name == "some updated name"
    end

    test "update_namespace/2 with invalid data returns error changeset" do
      namespace = namespace_fixture()
      assert {:error, %Ecto.Changeset{}} = Translate.update_namespace(namespace, @invalid_attrs)
      assert namespace == Translate.get_namespace!(namespace.id)
    end

    test "delete_namespace/1 deletes the namespace" do
      namespace = namespace_fixture()
      assert {:ok, %Namespace{}} = Translate.delete_namespace(namespace)
      assert_raise Ecto.NoResultsError, fn -> Translate.get_namespace!(namespace.id) end
    end

    test "change_namespace/1 returns a namespace changeset" do
      namespace = namespace_fixture()
      assert %Ecto.Changeset{} = Translate.change_namespace(namespace)
    end
  end
end
