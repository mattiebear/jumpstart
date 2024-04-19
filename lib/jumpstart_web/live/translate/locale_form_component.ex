defmodule JumpstartWeb.Translate.LocaleFormComponent do
  use JumpstartWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <.simple_form for={@form} phx-change="validate" phx-submit="save">
      <fieldset class="flex flex-col gap-y-4 mb-2">
        <.inputs_for :let={locale} field={@form[:locales]}>
          <.input field={locale[:id]} type="hidden" />
          <.input field={locale[:name]} label="Language" phx-debounce />
          <.input field={locale[:code]} label="Locale Code" phx-debounce />
          <.input field={locale[:source]} label="Source locale" type="checkbox" />
        </.inputs_for>

        <button
          class="px-4 py-3 rounded-xl flex justify-center items-center w-full border border-solid border-purple-500 text-purple-500"
          phx-click="add-locale"
          type="button"
        >
          <.icon name="hero-plus-circle" class="mr-2" /> Add locale
        </button>
      </fieldset>

      <:actions>
        <.button type="submit" phx-disable-with="Saving...">Save settings</.button>
      </:actions>
    </.simple_form>
    """
  end

  # @impl true
  # def update(%{post: post} = assigns, socket) do
  #   changeset = Articles.change_post(post)

  #   {:ok,
  #    socket
  #    |> assign(assigns)
  #    |> assign_form(changeset)}
  # end

  # @impl true
  # def handle_event("validate", %{"post" => post_params}, socket) do
  #   changeset =
  #     socket.assigns.post
  #     |> Articles.change_post(post_params)
  #     |> Map.put(:action, :validate)

  #   {:noreply, assign_form(socket, changeset)}
  # end

  # def handle_event("save", %{"post" => post_params}, socket) do
  #   save_post(socket, socket.assigns.action, post_params)
  # end

  # defp save_post(socket, :edit, post_params) do
  #   case Articles.update_post(socket.assigns.post, post_params) do
  #     {:ok, post} ->
  #       notify_parent({:saved, post})

  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Post updated successfully")
  #        |> push_patch(to: socket.assigns.patch)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign_form(socket, changeset)}
  #   end
  # end

  # defp save_post(socket, :new, post_params) do
  #   case Articles.create_post(post_params) do
  #     {:ok, post} ->
  #       notify_parent({:saved, post})

  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Post created successfully")
  #        |> push_patch(to: socket.assigns.patch)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign_form(socket, changeset)}
  #   end
  # end

  # defp assign_form(socket, %Ecto.Changeset{} = changeset) do
  #   assign(socket, :form, to_form(changeset))
  # end

  # defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
