defmodule JumpstartWeb.Translate.SettingsLive do
  alias Jumpstart.Translate
  alias Ecto.Changeset
  use JumpstartWeb, :live_view

  alias Jumpstart.Repo
  alias Jumpstart.Translate.{Locale, TranslateSettings}

  def mount(_params, _session, socket) do
    current_user =
      Repo.preload(socket.assigns.current_user, account: [translate_settings: :locales])

    settings = current_user.account.translate_settings
    form = TranslateSettings.changeset(settings, %{}) |> to_form()

    socket =
      socket
      |> assign(:form, form)
      |> assign(:settings, settings)

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end

  def handle_event("validate", %{"translate_settings" => params}, socket) do
    form =
      %TranslateSettings{}
      |> TranslateSettings.changeset(params)
      |> Map.put(:action, "validate")
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("add-locale", _params, socket) do
    socket =
      update(socket, :form, fn %{source: changeset} ->
        existing = Changeset.get_assoc(changeset, :locales)
        changeset = Changeset.put_assoc(changeset, :locales, existing ++ [%Locale{}])
        to_form(changeset)
      end)

    {:noreply, socket}
  end

  def handle_event("save", %{"translate_settings" => params}, socket) do
    case Translate.update_translate_settings(
           socket.assigns.settings,
           params
         ) do
      {:ok, _} ->
        {:noreply, put_flash(socket, :info, "Settings saved successfully.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        form = to_form(changeset)
        {:noreply, assign(socket, form: form)}
    end
  end
end
