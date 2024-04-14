defmodule JumpstartWeb.DashboardLive.Index do
  use JumpstartWeb, :live_view

  alias Phoenix.LiveView.JS, warn: false

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
