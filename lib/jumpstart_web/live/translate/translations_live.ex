defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.{Repo, Translate}
  alias Jumpstart.Translate.Phrase

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    socket =
      socket
      |> assign(:locales, locales)
      # TODO: Get translations for the namespace
      |> stream(:phrases, [])

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

  def handle_event("add_phrase", _params, socket) do
    form =
      Translate.init_phrase(socket.assigns.namespace, socket.assigns.locales)
      |> to_form(id: generate_id())

    {:noreply, stream_insert(socket, :phrases, form)}
  end

  def handle_event("save", %{"dom-id" => dom_id, "phrase" => phrase_params}, socket) do
    changeset =
      Translate.init_phrase(socket.assigns.namespace, socket.assigns.locales, phrase_params)

    case Repo.insert(changeset) do
      {:ok, phrase} ->
        {:noreply, put_flash(socket, :info, "Translations saved")}

      {:error, changeset} ->
        {:noreply, stream_insert(socket, :phrases, to_form(changeset, id: dom_id))}
    end
  end

  defp generate_id() do
    :crypto.strong_rand_bytes(8) |> Base.encode16()
  end
end
