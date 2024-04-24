defmodule JumpstartWeb.Translate.NamespacesLive do
  alias Jumpstart.Translate

  import Ecto.Query, warn: false

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream_namespaces()
      |> assign(%{namespace: nil, action: :index})

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    {:noreply, assign_navigation(socket, url)}
  end

  def handle_event("add_namespace", _params, socket) do
    {:noreply,
     assign(socket, %{
       namespace: %Translate.Namespace{},
       action: :new,
       modal_title: "Add namespace"
     })}
  end

  def handle_event("close_modal", _params, socket) do
    {:noreply, assign(socket, %{namespace: nil, action: :index})}
  end

  def handle_info({JumpstartWeb.Translate.NamespaceFormComponent, {:saved, namespace}}, socket) do
    socket =
      socket
      |> assign(%{namespace: nil, action: :index})
      |> stream_insert(:namespaces, namespace, at: 0)

    {:noreply, socket}
  end

  defp stream_namespaces(socket) do
    namespaces = Translate.list_namespaces_for_project(socket.assigns.current_project.id)
    stream(socket, :namespaces, namespaces)
  end
end
