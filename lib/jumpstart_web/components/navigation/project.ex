defmodule JumpstartWeb.Global.Project do
  use JumpstartWeb, :verified_routes

  import Phoenix.Component
  import Phoenix.LiveView
  import Jumpstart.Projects

  def on_mount(:fetch_current_project, _params, session, socket) do
    projects =
      list_projects_for_account(socket.assigns.current_user.account_id)

    current_project_id = session["current_project_id"]

    current_project =
      case current_project_id do
        nil -> nil
        _ -> get_project!(current_project_id)
      end

    socket =
      socket
      |> assign(:projects, projects)

    if current_project do
      socket =
        socket
        |> assign(:current_project, current_project)
        |> filter_projects()

      {:cont, socket}
    else
      activate_default_project(socket, projects)
    end
  end

  defp activate_default_project(socket, projects) do
    project = hd(projects)

    socket =
      socket
      |> assign(:current_project, project)
      |> filter_projects()
      |> redirect(to: ~p"/projects/#{project.id}/activate")

    {:halt, assign(socket, :current_project, project)}
  end

  defp filter_projects(socket) do
    socket
    |> update(:projects, fn projects ->
      Enum.filter(projects, &(&1.id != socket.assigns.current_project.id))
    end)
  end
end
