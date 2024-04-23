defmodule JumpstartWeb.Translate.TranslationsLive do
  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    # TODO: Make this automatic
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end

  def handle_info({:put_flash, type, message}, socket) do
    {:noreply, put_flash(socket, type, message)}
  end
end
