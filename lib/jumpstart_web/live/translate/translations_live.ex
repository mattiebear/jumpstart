defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.Translate

  use JumpstartWeb, :live_view

  import Ecto.Query, warn: false

  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream_namespaces()
      |> assign(%{namespace: nil, action: :index})

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    # TODO: Make this automatic
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end

  def handle_event("add_namespace", _params, socket) do
    {:noreply,
     assign(socket, %{
       namespace: %Translate.Namespace{},
       action: :new,
       modal_title: "Add namespace"
     })}
  end

  def handle_info({JumpstartWeb.Translate.NamespaceFormComponent, {:saved, namespace}}, socket) do
    socket =
      socket
      |> assign(%{namespace: nil, action: :index})
      |> stream_insert(:namespaces, namespace)

    {:noreply, socket}
  end

  def handle_info({:put_flash, type, message}, socket) do
    {:noreply, put_flash(socket, type, message)}
  end

  defp stream_namespaces(socket) do
    namespaces = Translate.list_namespaces_for_project(socket.assigns.current_project.id)
    stream(socket, :namespaces, namespaces)
  end
end
