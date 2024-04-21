defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.Translate

  use JumpstartWeb, :live_view

  import Ecto.Query, warn: false

  def mount(_params, _session, socket) do
    namespaces = Translate.list_namespaces_for_project(socket.assigns.current_project.id)

    {:ok, assign(socket, :namespaces, namespaces)}
  end

  def handle_params(_params, url, socket) do
    # TODO: Make this automatic
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end
end
