defmodule JumpstartWeb.Global.Navigation do
  use JumpstartWeb, :verified_routes

  def on_mount(:fetch_navigation, _params, _session, socket) do
    IO.puts("socket")

    {:cont, socket}
  end
end
