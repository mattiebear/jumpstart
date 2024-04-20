defmodule JumpstartWeb.Translate.SettingsLive do
  alias Jumpstart.Translate
  alias Jumpstart.Translate.Locale

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    socket =
      socket
      |> assign(:locale, nil)
      |> assign(:action, :index)
      |> stream(:locales, locales)

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end

  def handle_event("add_locale", _params, socket) do
    socket =
      socket
      |> assign(:locale, %Locale{})
      |> assign(:modal_title, "Add locale")
      |> assign(:action, :new)

    {:noreply, socket}
  end

  def handle_event("close_modal", _params, socket) do
    socket =
      socket
      |> assign(:locale, nil)
      |> assign(:action, :index)

    {:noreply, socket}
  end

  # def handle_info({JumpstartWeb.Translate.LocaleFormComponent, {:saved, locale}}, socket) do
  # socket = update(socket, :)

  # {:noreply, socket}

  # {:noreply, stream_insert(socket, :posts, post)}
  # end
end
