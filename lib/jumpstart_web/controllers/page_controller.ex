defmodule JumpstartWeb.PageController do
  use JumpstartWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
