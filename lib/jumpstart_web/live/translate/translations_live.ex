defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.{Repo, Translate}
  alias Jumpstart.Translate.Phrase

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    {:ok, assign(socket, :locales, locales)}
  end

  def handle_params(%{"id" => name}, url, socket) do
    namespace = Translate.get_namespace_by_name!(socket.assigns.current_project.id, name)
    phrases = Translate.list_phrases_for_namespace(namespace.id)

    forms = Enum.map(phrases, &Translate.change_phrase/1) |> Enum.map(&to_form/1)

    socket =
      socket
      |> assign_navigation(url)
      |> assign(:namespace, namespace)
      |> stream(:phrases, forms)

    {:noreply, socket}
  end

  def handle_event("add_phrase", _params, socket) do
    form =
      %Phrase{}
      |> Ecto.Changeset.change(%{
        translations: Enum.map(socket.assigns.locales, fn locale -> %{locale_id: locale.id} end)
      })
      |> to_form(id: generate_id())

    {:noreply, stream_insert(socket, :phrases, form, at: 0)}
  end

  def handle_event("save", %{"dom-id" => dom_id, "phrase" => phrase_params}, socket) do
    changeset =
      %Phrase{}
      |> Translate.change_phrase(phrase_params)
      |> Ecto.Changeset.put_assoc(:namespace, socket.assigns.namespace)

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
