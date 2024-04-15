defmodule JumpstartWeb.ProjectController do
  use JumpstartWeb, :controller

  def activate(conn, %{"id" => id}) do
    conn
    |> put_session("current_project_id", id)
    |> redirect(to: ~p"/dashboard")
  end
end
