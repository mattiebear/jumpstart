defmodule JumpstartWeb.Translate.NamespacesLive do
  alias Jumpstart.Translate

  import Ecto.Query, warn: false

  use JumpstartWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream_namespaces()
      |> assign(:namespace, nil)
      |> allow_upload(:files, accept: ~w(.json))

    {:ok, socket}
  end

  def handle_params(_params, url, socket) do
    socket =
      socket
      |> assign_navigation(url)
      |> assign(:action, socket.assigns.live_action || :index)

    {:noreply, socket}
  end

  # TODO: Change to use /new path
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

  def handle_event("save", _params, socket) do
    # TODO: Update to use job instead of handling here
    consume_uploaded_entries(socket, :files, fn %{path: path}, entry ->
      {entry.client_name, path}

      dest = Path.join("priv/static/uploads", Path.basename(path))
      File.cp!(path, dest)
      {:ok, Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")}
    end)

    {:noreply, socket}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :files, ref)}
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

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
end
