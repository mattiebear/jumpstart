defmodule JumpstartWeb.Session.Project do
  import Phoenix.Component

  def on_mount(:fetch_current_project, _params, session, socket) do
    projects =
      Jumpstart.Projects.list_projects_for_account(socket.assigns.current_user.account_id)

    current_project_id = session["current_project_id"]
    current_project = Enum.find(projects, &(&1.id == current_project_id))

    if current_project do
      socket =
        socket
        |> assign(:projects, projects)
        |> assign(:current_project, current_project)

      {:cont, socket}
    else
      activate_default_project(socket, projects)
    end
  end

  defp activate_default_project(socket, projects) do
    first_project = hd(projects)

    socket =
      socket
      |> assign(:projects, projects)
      |> assign(:current_project, first_project)

    {:cont, socket}
  end
end
