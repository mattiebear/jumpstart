defmodule JumpstartWeb.Translate.SettingsLive do
  use JumpstartWeb, :live_view

  alias Jumpstart.Repo

  def mount(_params, _session, socket) do
    current_user = Repo.preload(socket.assigns.current_user, account: [translate_settings: :locales])

    {:ok, assign(socket, :account, current_user.account)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
