defmodule JumpstartWeb.Translate.SettingsLive do
  alias Jumpstart.Repo
  alias Jumpstart.Translate.Locale

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    user =
      socket.assigns.current_user
      |> Repo.preload(account: :translate_settings)

    locales = user.account.translate_settings |> Repo.preload(:locales) |> Map.get(:locales)

    socket =
      socket
      |> assign(:locale, nil)
      |> assign(:action, :index)
      |> assign(:settings, user.account.translate_settings)
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

  def handle_info({JumpstartWeb.Translate.LocaleFormComponent, {:saved, locale}}, socket) do
    # socket = update(socket, :)

    # {:noreply, socket}

    # {:noreply, stream_insert(socket, :posts, post)}
  end
end
