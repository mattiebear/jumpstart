defmodule JumpstartWeb.Translate.NamespaceFormComponent do
  alias Ecto.Changeset
  alias Jumpstart.Repo
  alias Jumpstart.Translate
  alias Jumpstart.Translate.Namespace

  use JumpstartWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          Organize translations into a shared namespace. The namespace will be used as a file name when translations are downloaded or saved to the cloud.
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        phx-change="validate"
        phx-submit="save"
        phx-target={@myself}
        autocomplete="off"
      >
        <fieldset class="flex flex-col gap-y-4 mb-2">
          <.input field={@form[:id]} type="hidden" />
          <.input field={@form[:name]} label="Name" phx-debounce />
        </fieldset>

        <:actions>
          <.button type="submit" phx-disable-with="Saving...">Save</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{namespace: namespace} = assigns, socket) do
    changeset = Translate.change_namespace(namespace)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"namespace" => params}, socket) do
    form =
      %Namespace{}
      |> Translate.change_namespace(params)
      |> Map.put(:action, "validate")
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("save", %{"namespace" => params}, socket) do
    save_namespace(socket, socket.assigns.action, params)
  end

  defp save_namespace(socket, :edit, params) do
    case Translate.update_namespace(socket.assigns.namespace, params) do
      {:ok, namespace} ->
        notify_parent({:saved, namespace})

        {:noreply, put_flash!(socket, :info, "Namespace updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_namespace(socket, :new, params) do
    changeset =
      %Namespace{}
      |> Translate.change_namespace(params)
      |> Changeset.put_assoc(:project, socket.assigns.project)

    case Repo.insert(changeset) do
      {:ok, namespace} ->
        notify_parent({:saved, namespace})
        {:noreply, put_flash!(socket, :info, "Namespace created successfully.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        form = to_form(changeset)
        {:noreply, assign(socket, form: form)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp put_flash!(socket, type, message) do
    send(self(), {:put_flash, type, message})
    socket
  end
end
