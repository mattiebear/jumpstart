defmodule JumpstartWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use JumpstartWeb, :controller
      use JumpstartWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def router do
    quote do
      use Phoenix.Router, helpers: false

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: JumpstartWeb.Layouts]

      import Plug.Conn
      import JumpstartWeb.Gettext

      unquote(verified_routes())
    end
  end

  def live_view do
    quote do
      import JumpstartWeb.Navigation

      use Phoenix.LiveView,
        layout: {JumpstartWeb.Layouts, :app}

      # TODO: Move this to an external module and import it
      # Allows for flash messages to be created from Live Components
      def handle_info({:put_flash, type, message}, socket) do
        {:noreply, Phoenix.LiveView.put_flash(socket, type, message)}
      end

      unquote(html_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      # TODO: Move this to an external module and import it
      defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

      defp put_flash!(socket, type, message) do
        send(self(), {:put_flash, type, message})
        socket
      end

      unquote(html_helpers())
    end
  end

  def html do
    quote do
      use Phoenix.Component

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      # Include general helpers for rendering HTML
      unquote(html_helpers())
    end
  end

  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML
      # Core UI components and translation
      import JumpstartWeb.CoreComponents
      import JumpstartWeb.Gettext

      # Shortcut for generating JS commands
      alias Phoenix.LiveView.JS

      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: JumpstartWeb.Endpoint,
        router: JumpstartWeb.Router,
        statics: JumpstartWeb.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
