defmodule JumpstartWeb.Translate.SettingsLive do
  alias Jumpstart.Translate
  alias Jumpstart.Translate.Locale

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    socket =
      socket
      |> assign(%{locale: nil, action: :index})
      |> stream(:locales, locales)

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end

  def handle_event("add_locale", _params, socket) do
    {:noreply, assign(socket, %{locale: %Locale{}, action: :new, modal_title: "Add locale"})}
  end

  def handle_event("edit_locale", %{"id" => id}, socket) do
    locale = Translate.get_locale!(id)

    {:noreply, assign(socket, %{locale: locale, action: :edit, modal_title: "Edit locale"})}
  end

  def handle_event("close_modal", _params, socket) do
    {:noreply, assign(socket, %{locale: nil, action: :index})}
  end

  def handle_info({JumpstartWeb.Translate.LocaleFormComponent, {:saved, locale}}, socket) do
    socket =
      socket
      |> assign(%{locale: nil, action: :index})
      |> stream_insert(:locales, locale)

    {:noreply, socket}
  end
end
