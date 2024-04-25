defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.{Repo, Translate}

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    {:ok, assign(socket, :locales, locales)}
  end

  def handle_params(%{"id" => name}, url, socket) do
    namespace = Translate.get_namespace_by_name!(socket.assigns.current_project.id, name)
    phrases = Translate.list_phrases_for_namespace(namespace.id) |> Repo.preload(:translations)

    forms = Enum.map(phrases, &Translate.change_phrase/1) |> Enum.map(&to_form/1)

    IO.inspect(phrases)

    socket =
      socket
      |> assign(:namespace, namespace)
      |> assign_navigation(url)
      |> stream(:phrases, forms)

    {:noreply, socket}
  end

  def handle_event("add_phrase", _params, socket) do
    form =
      Translate.init_phrase(socket.assigns.namespace, socket.assigns.locales)
      |> to_form(id: generate_id())

    {:noreply, stream_insert(socket, :phrases, form, at: 0)}
  end

  def handle_event("save", %{"dom-id" => dom_id, "phrase" => phrase_params}, socket) do
    changeset =
      Translate.init_phrase(socket.assigns.namespace, socket.assigns.locales, phrase_params)

    case Repo.insert(changeset) do
      {:ok, phrase} ->
        form = Translate.change_phrase(phrase) |> to_form()

        socket =
          socket
          |> put_flash(:info, "Translations saved")
          |> stream_delete_by_dom_id(:phrases, dom_id)
          |> stream_insert(:phrases, form)

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, stream_insert(socket, :phrases, to_form(changeset, id: dom_id))}
    end
  end

  defp generate_id() do
    :crypto.strong_rand_bytes(8) |> Base.encode16()
  end
end
