defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.{Repo, Translate}
  alias Jumpstart.Translate.{Phrase, Translation}

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    locales = Translate.list_locales_for_project(socket.assigns.current_project.id)

    {:ok, assign(socket, %{locales: locales, action: :index})}
  end

  def handle_params(params, url, socket) do
    socket =
      socket
      |> assign_navigation(url)
      |> assign_translations(params)
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:modal_title, nil)
    |> assign(:phrase, nil)
  end

  defp apply_action(socket, :new, _params) do
    phrase = %Phrase{
      translations:
        Enum.map(socket.assigns.locales, fn locale -> %Translation{locale_id: locale.id} end)
    }

    socket
    |> assign(:modal_title, "Add new phrase")
    |> assign(:phrase, phrase)
  end

  defp apply_action(socket, :edit, %{"phrase_id" => id}) do
    socket
    |> assign(:modal_title, "Edit phrase")

    # |> assign(:page_title, "Edit Thing")
    # |> assign(:thing, Stuff.get_thing!(id))
  end

  defp assign_translations(socket, %{"namespace_id" => name} = params) do
    namespace = Translate.get_namespace_by_name!(socket.assigns.current_project.id, name)
    phrases = Translate.list_phrases_for_namespace(namespace.id)

    data =
      Enum.map(phrases, fn phrase ->
        %{
          id: phrase.id,
          phrase: phrase,
          source: Phrase.source(phrase)
        }
      end)

    socket
    |> assign(:namespace, namespace)
    |> stream(:phrases, data)
  end

  # def handle_event("add_phrase", _params, socket) do
  #   form =
  #     %Phrase{}
  #     |> Ecto.Changeset.change(%{
  #       translations: Enum.map(socket.assigns.locales, fn locale -> %{locale_id: locale.id} end)
  #     })
  #     |> to_form(id: generate_id())

  #   {:noreply, stream_insert(socket, :phrases, form, at: 0)}
  # end

  # def handle_event("save", %{"dom-id" => dom_id, "phrase" => phrase_params}, socket) do
  #   changeset =
  #     %Phrase{}
  #     |> Translate.change_phrase(phrase_params)
  #     |> Ecto.Changeset.put_assoc(:namespace, socket.assigns.namespace)

  #   case Repo.insert(changeset) do
  #     {:ok, phrase} ->
  #       form = Translate.change_phrase(phrase) |> to_form()

  #       socket =
  #         socket
  #         |> put_flash(:info, "Translations saved")
  #         |> stream_delete_by_dom_id(:phrases, dom_id)
  #         |> stream_insert(:phrases, form)

  #       {:noreply, socket}

  #     {:error, changeset} ->
  #       {:noreply, stream_insert(socket, :phrases, to_form(changeset, id: dom_id))}
  #   end
  # end

  # defp generate_id() do
  #   :crypto.strong_rand_bytes(8) |> Base.encode16()
  # end
end
