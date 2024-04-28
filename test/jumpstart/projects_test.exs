defmodule Jumpstart.ProjectsTest do
  use Jumpstart.DataCase

  alias Jumpstart.{AccountsFixtures, Projects}

  describe "projects" do
    alias Jumpstart.Projects.Project

    import Jumpstart.ProjectsFixtures

    @invalid_attrs %{name: nil}

    test "list_projects_for_account/1 returns all projects for an account" do
      account = AccountsFixtures.account_fixture()
      project1 = project_on_account_fixture(account.id)
      project2 = project_on_account_fixture(account.id)

      assert Projects.list_projects_for_account(account.id) == [project1, project2]
    end

    test "create_project_on_account/1 with valid data creates a project" do
      account = AccountsFixtures.account_fixture()

      valid_attrs = %{name: "some name"}

      assert {:ok, %Project{} = project} =
               Projects.create_project_on_account(account.id, valid_attrs)

      assert project.name == "some name"
    end

    test "create_project_on_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project_on_account(@invalid_attrs)
    end
  end
end
