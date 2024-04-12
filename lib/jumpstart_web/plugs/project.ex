defmodule JumpstartWeb.Plugs.Project do
  import Plug.Conn

  def fetch_current_project(conn, _opts) do
    case conn.assigns.current_user do
      nil -> conn
      _ -> fetch_projects(conn)
    end
  end

  defp fetch_projects(conn) do
    projects = Jumpstart.Projects.list_projects_for_account(conn.assigns.current_user.account_id)
    current_project_id = get_session(conn, :current_project_id)

    current_project = Enum.find(projects, &(&1.id == current_project_id))

    if current_project do
      conn
      |> assign(:projects, projects)
      |> assign(:current_project, current_project)
    else
      activate_default_project(conn, projects)
    end
  end

  defp activate_default_project(conn, projects) do
    first_project = hd(projects)

    conn
    |> put_session(:current_project_id, first_project.id)
    |> assign(:projects, projects)
    |> assign(:current_project, first_project)
  end
end
