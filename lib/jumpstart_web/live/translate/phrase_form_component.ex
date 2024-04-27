defmodule JumpstartWeb.Translate.PhraseFormComponent do
  alias Ecto.Changeset
  alias Jumpstart.Repo
  alias Jumpstart.Translate
  alias Jumpstart.Translate.Phrase

  use JumpstartWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          Set the text of the source phrase and translations into other languages
        </:subtitle>
      </.header>

      <.simple_form for={@form} phx-target={@myself} autocomplete="off">
        <fieldset class="flex flex-col gap-y-4 mb-2">
          <.input field={@form[:id]} type="hidden" />
          <.input field={@form[:key]} label="Key" placeholder="phrase.key" phx-debounce />
          <.input type="textarea" field={@form[:notes]} label="Notes" phx-debounce />

          <.inputs_for :let={translation} field={@form[:translations]}>
            <.input field={translation[:id]} type="hidden" />
            <.input field={translation[:locale_id]} type="hidden" />

            <div class="flex gap-x-2 w-full">
              <.input field={translation[:value]} class="w-full" phx-debounce />
            </div>
          </.inputs_for>
        </fieldset>

        <:actions>
          <.button type="submit" phx-disable-with="Saving...">Save</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    changeset = Translate.change_phrase(assigns.phrase)
    source_locale = Enum.find(assigns.locales, & &1.is_source)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:source_locale, source_locale)
     |> assign_form(changeset)}
  end

  # @impl true
  # def handle_event("validate", %{"namespace" => params}, socket) do
  #   form =
  #     %Namespace{}
  #     |> Translate.change_namespace(params)
  #     |> Map.put(:action, "validate")
  #     |> to_form()

  #   {:noreply, assign(socket, form: form)}
  # end

  # @impl true
  # def handle_event("save", %{"namespace" => params}, socket) do
  #   save_namespace(socket, socket.assigns.action, params)
  # end

  # defp save_namespace(socket, :edit, params) do
  #   case Translate.update_namespace(socket.assigns.namespace, params) do
  #     {:ok, namespace} ->
  #       notify_parent({:saved, namespace})

  #       {:noreply, put_flash!(socket, :info, "Namespace updated successfully")}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign_form(socket, changeset)}
  #   end
  # end

  # defp save_namespace(socket, :new, params) do
  #   changeset =
  #     %Namespace{}
  #     |> Translate.change_namespace(params)
  #     |> Changeset.put_assoc(:project, socket.assigns.project)

  #   case Repo.insert(changeset) do
  #     {:ok, namespace} ->
  #       notify_parent({:saved, namespace})
  #       {:noreply, put_flash!(socket, :info, "Namespace created successfully.")}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       form = to_form(changeset)
  #       {:noreply, assign(socket, form: form)}
  #   end
  # end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  # defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  # defp put_flash!(socket, type, message) do
  #   send(self(), {:put_flash, type, message})
  #   socket
  # end
end
