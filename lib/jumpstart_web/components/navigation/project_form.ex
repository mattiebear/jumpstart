defmodule JumpstartWeb.Navigation.ProjectForm do
  use JumpstartWeb, :live_component

  alias Jumpstart.Projects
  alias Jumpstart.Projects.Project

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        Create new project
        <:subtitle>Add a new project to group all of your work</:subtitle>
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
    account_id = socket.assigns.current_user.account_id

    case Projects.create_project_on_account(account_id, project_params) do
      {:ok, project} ->
        notify_parent({:saved, project})

        {:noreply,
         socket
         |> put_flash(:info, "Project created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :project_form, to_form(changeset))
  end
end
