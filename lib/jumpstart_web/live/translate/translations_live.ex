defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.Translate

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    socket =
      socket
      |> assign(:locales, locales)

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    # TODO: Make this automatic
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end
end
