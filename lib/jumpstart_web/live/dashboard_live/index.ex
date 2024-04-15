defmodule JumpstartWeb.DashboardLive.Index do
  use JumpstartWeb, :live_view

  alias Phoenix.LiveView.JS, warn: false

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def handle_info({JumpstartWeb.Global.ProjectForm, {:saved, _project}}, socket) do
    # Perform full page reload to update the project list
    {:noreply, socket |> push_redirect(to: ~p"/dashboard")}
  end
end
