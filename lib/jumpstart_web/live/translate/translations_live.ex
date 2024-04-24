defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.Translate
  alias Jumpstart.Translate.{Phrase, Translation}

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    socket =
      socket
      |> assign(:locales, locales)
      # TODO: Get translations for the namespace
      |> stream(:translations, [])

    {:ok, socket}
  end

  def handle_params(%{"id" => name}, url, socket) do
    namespace = Translate.get_namespace_by_name!(socket.assigns.current_project.id, name)

    socket =
      socket
      |> assign(:namespace, namespace)
      |> assign_navigation(url)

    {:noreply, socket}
  end

  def handle_event("add_translation", _params, socket) do
    # Create a changeset for a phrase with each of the locales as a translation
    # Convert to form data
    {:noreply, socket}
  end
end
