defmodule JumpstartWeb.DashboardController do
  use JumpstartWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
