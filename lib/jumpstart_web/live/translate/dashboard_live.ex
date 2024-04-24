defmodule JumpstartWeb.Translate.DashboardLive do
  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    {:noreply, assign_navigation(socket, url)}
  end
end
