defmodule JumpstartWeb.Translate.LocaleFormComponent do
  alias Ecto.Changeset
  alias Jumpstart.Repo
  alias Jumpstart.Translate
  alias Jumpstart.Translate.Locale

  use JumpstartWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Manage the locales supported by by your application</:subtitle>
      </.header>

      <.simple_form for={@form} phx-change="validate" phx-submit="save" phx-target={@myself}>
        <fieldset class="flex flex-col gap-y-4 mb-2">
          <.input field={@form[:id]} type="hidden" />
          <.input field={@form[:name]} label="Language" phx-debounce />
          <.input field={@form[:code]} label="Locale Code" phx-debounce />
        </fieldset>

        <:actions>
          <.button type="submit" phx-disable-with="Saving...">Save</.button>

          <%= if @action == :edit and !@form[:is_source].value do %>
            <.button
              phx-click="set_source_locale"
              phx-disable-with="Setting..."
              phx-target={@myself}
              data-confirm="Are you sure?"
            >
              Set as Source
            </.button>
          <% end %>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{locale: locale} = assigns, socket) do
    changeset = Translate.change_locale(locale)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"locale" => params}, socket) do
    form =
      %Locale{}
      |> Translate.change_locale(params)
      |> Map.put(:action, "validate")
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("set_source_locale", _params, socket) do
    Translate.set_source_locale(socket.assigns.locale)
    notify_parent({:source_set, socket.assigns.locale})

    {:noreply, put_flash!(socket, :info, "Source locale set successfully")}
  end

  @impl true
  def handle_event("save", %{"phrase" => params}, socket) do
    save_locale(socket, socket.assigns.action, params)
  end

  defp save_locale(socket, :edit, params) do
    case Translate.update_locale(socket.assigns.locale, params) do
      {:ok, locale} ->
        notify_parent({:saved, locale})

        {:noreply, put_flash!(socket, :info, "Locale updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_locale(socket, :new, params) do
    changeset =
      %Locale{}
      |> Translate.change_locale(params)
      |> Changeset.put_assoc(:project, socket.assigns.project)

    case Repo.insert(changeset) do
      {:ok, locale} ->
        notify_parent({:saved, locale})
        {:noreply, put_flash!(socket, :info, "Locale created successfully.")}

      {:error, %Ecto.Changeset{} = changeset} ->
        form = to_form(changeset)
        {:noreply, assign(socket, form: form)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
