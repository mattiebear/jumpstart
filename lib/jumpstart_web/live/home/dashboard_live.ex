defmodule JumpstartWeb.Home.DashboardLive do
  use JumpstartWeb, :live_view

  alias Phoenix.LiveView.JS, warn: false

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    {:noreply, assign_navigation(socket, url)}
  end

  def handle_info({JumpstartWeb.Navigation.ProjectForm, {:saved, _project}}, socket) do
    # Perform full page reload to update the project list
    {:noreply, socket |> push_redirect(to: ~p"/dashboard")}
  end
end
