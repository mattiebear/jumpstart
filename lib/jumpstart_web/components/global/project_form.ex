defmodule JumpstartWeb.Global.ProjectForm do
  use JumpstartWeb, :live_component

  alias Jumpstart.Projects
  alias Jumpstart.Projects.Project

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        Create new project
        <:subtitle>Add a new project to group all of your features</:subtitle>
      </.header>

      <.simple_form
        for={@project_form}
        id="project-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@project_form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Create project</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    changeset = Projects.change_project(%Project{}, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"project" => project_params}, socket) do
    changeset =
      %Project{}
      |> Projects.change_project(project_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"project" => project_params}, socket) do
    # case Projects.create_project_on_account(project_params) do
    #   {:ok, post} ->
    #     notify_parent({:saved, post})

    #     {:noreply,
    #      socket
    #      |> put_flash(:info, "Post created successfully")
    #      |> push_patch(to: socket.assigns.patch)}

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     {:noreply, assign_form(socket, changeset)}
    # end
    {:noreply, socket}
  end

  # defp save_post(socket, :new, post_params) do

  # end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :project_form, to_form(changeset))
  end

  # defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
