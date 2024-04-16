defmodule JumpstartWeb.Router do
  use JumpstartWeb, :router

  import JumpstartWeb.Auth.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {JumpstartWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", JumpstartWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:jumpstart, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: JumpstartWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", JumpstartWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/", PageController, :home

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{JumpstartWeb.Auth.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", Auth.UserRegistrationLive, :new
      live "/users/log_in", Auth.UserLoginLive, :new
      live "/users/reset_password", Auth.UserForgotPasswordLive, :new
      live "/users/reset_password/:token", Auth.UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", JumpstartWeb do
    pipe_through [:browser, :require_authenticated_user]

    # TODO: Turn this into a POST instead?
    get "/projects/:id/activate", ProjectController, :activate

    live_session :require_authenticated_user,
      on_mount: [
        {JumpstartWeb.Auth.UserAuth, :ensure_authenticated},
        {JumpstartWeb.Global.Project, :fetch_current_project}
      ] do
      live "/users/settings", Auth.UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", Auth.UserSettingsLive, :confirm_email

      live "/dashboard", DashboardLive.Index, :index

      live "/translate/settings", Translate.SettingsLive, :edit
      live "/translate", Translate.DashboardLive, :index
    end
  end

  scope "/", JumpstartWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{JumpstartWeb.Auth.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", Auth.UserConfirmationLive, :edit
      live "/users/confirm", Auth.UserConfirmationInstructionsLive, :new
    end
  end
end
