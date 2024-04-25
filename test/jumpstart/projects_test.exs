defmodule Jumpstart.ProjectsTest do
  # use Jumpstart.DataCase

  # alias Jumpstart.{AccountsFixtures, Projects}

  # describe "projects" do
  #   alias Jumpstart.Projects.Project

  #   import Jumpstart.ProjectsFixtures

  #   @invalid_attrs %{name: nil}

  #   test "create_project_on_account/1 with valid data creates a project" do
  #     account = AccountsFixtures.account_fixture()

  #     valid_attrs = %{name: "some name", account_id: account.id}

  #     assert {:ok, %Project{} = project} = Projects.create_project_on_account(valid_attrs)
  #     assert project.name == "some name"
  #   end

  #   test "create_project_on_account/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Projects.create_project_on_account(@invalid_attrs)
  #   end
  # end
end
