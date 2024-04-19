defmodule JumpstartWeb.Translate.LocaleFormComponent do
  use JumpstartWeb, :live_component

  alias Jumpstart.Translate

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
          <.button type="submit" phx-disable-with="Saving...">Save settings</.button>
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

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  # defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
