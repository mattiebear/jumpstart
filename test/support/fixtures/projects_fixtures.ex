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

    attrs =
      attrs
      |> Enum.into(%{
        name: "some name"
      })

    {:ok, project} =
      Jumpstart.Projects.create_project_on_account(account.id, attrs)

    project
  end
end
