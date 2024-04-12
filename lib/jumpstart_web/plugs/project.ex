defmodule JumpstartWeb.Plugs.Project do
  import Plug.Conn

  def fetch_project_state(conn, _opts) do
    case conn.assigns.current_user do
      nil -> conn
      _ -> fetch_projects(conn)
    end
  end

  defp fetch_projects(conn) do
    projects = Jumpstart.Projects.list_projects_for_account(conn.assigns.current_user.account_id)
    active_project_id = get_session(conn, :active_project_id)

    active_project = Enum.find(projects, &(&1.id == active_project_id))

    if active_project do
      conn
      |> assign(:projects, projects)
      |> assign(:active_project, active_project)
    else
      activate_default_project(conn, projects)
    end
  end

  defp activate_default_project(conn, projects) do
    first_project = hd(projects)

    conn
    |> put_session(:active_project_id, first_project.id)
    |> assign(:projects, projects)
    |> assign(:active_project, first_project)
  end
end
