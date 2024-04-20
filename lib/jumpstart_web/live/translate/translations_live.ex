defmodule JumpstartWeb.Translate.TranslationsLive do
  alias Jumpstart.Translate.Namespace
  alias Jumpstart.Repo

  use JumpstartWeb, :live_view

  import Ecto.Query, warn: false

  def mount(_params, _session, socket) do
    namespaces = from(n in Namespace, where: n.project_id == ^socket.assigns.current_project.id) |> Repo.all()

    {:ok, assign(socket, :namespaces, namespaces)}
  end

  @spec handle_params(any(), binary() | URI.t(), map()) :: {:noreply, map()}
  def handle_params(_params, url, socket) do
    # TODO: Make this automatic
    navigation = JumpstartWeb.Navigation.build_navigation(url)

    {:noreply, assign(socket, :navigation, navigation)}
  end
end
