defmodule Jumpstart.ProjectsFixtures do
  alias Jumpstart.AccountsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jumpstart.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    account = AccountsFixtures.account_fixture()

    {:ok, project} =
      attrs
      |> Enum.into(%{
        account_id: account.id,
        name: "some name"
      })
      |> Jumpstart.Projects.create_project()

    project
  end
end
