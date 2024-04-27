defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.Translate
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

  def handle_info({JumpstartWeb.Translate.PhraseFormComponent, {:saved, phrase}}, socket) do
    socket =
      socket
      |> assign(%{phrase: nil, modal_title: nil})
      |> stream_insert(:phrases, phrase)

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
end
