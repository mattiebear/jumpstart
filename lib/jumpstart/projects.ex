defmodule Jumpstart.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias Jumpstart.Repo

  alias Jumpstart.Projects.Project

  @doc """
  Lists all projects for an account.

  ## Examples

      iex> Jumpstart.Projects.list_projects_for_account(1)
      [%Jumpstart.Projects.Project{...}]
  """
  def list_projects_for_account(account_id) do
    from(p in Project, where: p.account_id == ^account_id) |> Repo.all()
  end

  @doc """
  Creates a project on an account.

  ## Examples

      iex> Jumpstart.Projects.create_project_on_account(1, %{name: "My Project"})
      {:ok, %Jumpstart.Projects.Project{...}}

  """
  def create_project_on_account(account_id, attrs \\ %{}) do
    %Project{account_id: account_id}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end
end
