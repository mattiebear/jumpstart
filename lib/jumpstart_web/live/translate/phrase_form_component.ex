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

      <.simple_form
        for={@form}
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        autocomplete="off"
      >
        <fieldset class="flex flex-col gap-y-4 mb-2">
          <.input field={@form[:id]} type="hidden" />
          <.input field={@form[:key]} label="Key" placeholder="phrase.key" phx-debounce />

          <div class="hidden">
            <.input type="textarea" field={@form[:notes]} label="Notes" phx-debounce />
          </div>

          <h2 class="mt-4 text-lg text-zinc-300">Translations</h2>
          <.inputs_for :let={translation} field={@form[:translations]}>
            <div>
              <.input field={translation[:id]} type="hidden" />
              <.input field={translation[:locale_id]} type="hidden" />

              <% locale = Enum.find(@locales, &(&1.id == translation[:locale_id].value)) %>

              <div class={"#{if locale.is_source, do: "border-purple-500", else: "border-zinc-800"} border border-solid rounded-xl p-2 flex gap-x-2 items-center"}>
                <img
                  src={"https://unpkg.com/language-icons/icons/#{locale.code}.svg"}
                  class="w-8 h-8 rounded-full"
                />

                <%= if locale.is_source do %>
                  <div class="inline-block border border-solid border-green-500 text-green-500 rounded-full px-4">
                    Source
                  </div>
                <% end %>

                <input
                  class="flex-1 rounded-lg sm:text-sm py-1 px-2"
                  placeholder={"#{locale.name} translation"}
                  name={translation[:value].name}
                  value={translation[:value].value}
                />
              </div>
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

  @impl true
  def handle_event("validate", %{"phrase" => params}, socket) do
    form =
      %Phrase{}
      |> Translate.change_phrase(params)
      |> Map.put(:action, "validate")
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("save", %{"phrase" => params}, socket) do
    save_phrase(socket, socket.assigns.action, params)
  end

  # defp save_phrase(socket, :edit, params) do
  #   case Translate.update_namespace(socket.assigns.namespace, params) do
  #     {:ok, namespace} ->
  #       notify_parent({:saved, namespace})

  #       {:noreply, put_flash!(socket, :info, "Namespace updated successfully")}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign_form(socket, changeset)}
  #   end
  # end

  defp save_phrase(socket, :new, params) do
    changeset =
      %Phrase{}
      |> Translate.change_phrase(params)
      |> Changeset.put_assoc(:namespace, socket.assigns.namespace)

    case Repo.insert(changeset) do
      {:ok, phrase} ->
        notify_parent({:saved, phrase})

        socket =
          socket
          |> push_patch(to: socket.assigns.patch)
          |> put_flash!(:info, "Phrase created successfully.")

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        form = to_form(changeset)
        {:noreply, assign(socket, form: form)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
