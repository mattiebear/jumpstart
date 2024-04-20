defmodule Jumpstart.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false

  alias Jumpstart.Repo
  alias Jumpstart.Projects.Project

  def list_projects_for_account(account_id) do
    from(p in Project, where: p.account_id == ^account_id) |> Repo.all()
  end

  def create_project_on_account(account_id, attrs \\ %{}) do
    %Project{account_id: account_id}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def get_project!(id), do: Repo.get!(Project, id)

  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end
end
