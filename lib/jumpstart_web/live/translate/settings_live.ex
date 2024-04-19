defmodule JumpstartWeb.Translate.SettingsLive do
  alias Ecto.Changeset
  alias Jumpstart.Repo
  alias Jumpstart.Translate
  alias Jumpstart.Translate.Locale

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    user =
      socket.assigns.current_user
      |> Repo.preload(account: [translate_settings: :locales])

    socket =
      socket
      |> assign(:locale, nil)
      |> assign(:action, :index)
      |> assign(:locales, user.account.translate_settings.locales)

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end

  # def handle_event("validate", %{"translate_settings" => params}, socket) do
  #   form =
  #     %TranslateSettings{}
  #     |> TranslateSettings.changeset(params)
  #     |> Map.put(:action, "validate")
  #     |> to_form()

  #   {:noreply, assign(socket, form: form)}
  # end

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

  # def handle_event("save", %{"translate_settings" => params}, socket) do
  #   case Translate.update_translate_settings(
  #          socket.assigns.settings,
  #          params
  #        ) do
  #     {:ok, _} ->
  #       {:noreply, put_flash(socket, :info, "Settings saved successfully.")}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       form = to_form(changeset)
  #       {:noreply, assign(socket, form: form)}
  #   end
  # end
end
