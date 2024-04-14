defmodule JumpstartWeb.Global.Project do
  import Phoenix.Component
  import Jumpstart.Projects

  alias Jumpstart.Projects.Project

  def on_mount(:fetch_current_project, _params, session, socket) do
    projects =
      list_projects_for_account(socket.assigns.current_user.account_id)

    current_project_id = session["current_project_id"]
    current_project = Enum.find(projects, &(&1.id == current_project_id))

    socket =
      socket
      |> assign(:projects, projects)

    if current_project do
      {:cont, assign(socket, :current_project, current_project)}
    else
      activate_default_project(socket, projects)
    end
  end

  defp activate_default_project(socket, projects) do
    # TODO: Save this in session

    first_project = hd(projects)

    {:cont, assign(socket, :current_project, first_project)}
  end
end
