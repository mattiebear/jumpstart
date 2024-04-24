defmodule JumpstartWeb.Translate.SettingsLive do
  alias Jumpstart.Translate
  alias Jumpstart.Translate.Locale

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream_locales()
      |> assign(%{locale: nil, action: :index})

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    {:noreply, assign_navigation(socket, url)}
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

  def handle_info({JumpstartWeb.Translate.LocaleFormComponent, {:source_set, _locale}}, socket) do
    socket =
      socket
      |> stream_locales()
      |> assign(%{locale: nil, action: :index})

    {:noreply, socket}
  end

  defp stream_locales(socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)
    stream(socket, :locales, locales)
  end
end
