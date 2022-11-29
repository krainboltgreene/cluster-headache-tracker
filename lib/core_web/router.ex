defmodule CoreWeb.Router do
  use CoreWeb, :router

  import CoreWeb.AccountAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CoreWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_account
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", CoreWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:core, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CoreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", CoreWeb do
    pipe_through [:browser, :redirect_if_account_is_authenticated]

    live_session :redirect_if_account_is_authenticated,
      on_mount: [{CoreWeb.AccountAuth, :redirect_if_account_is_authenticated}] do
      live "/accounts/register", AccountRegistrationLive, :new
      live "/accounts/log_in", AccountLoginLive, :new
      live "/accounts/reset_password", AccountForgotPasswordLive, :new
      live "/accounts/reset_password/:token", AccountResetPasswordLive, :edit
    end

    post "/accounts/log_in", AccountSessionController, :create
  end

  scope "/", CoreWeb do
    pipe_through [:browser, :require_authenticated_account]

    live_session :require_authenticated_account,
      on_mount: [{CoreWeb.AccountAuth, :ensure_authenticated}] do
      live "/accounts/settings", AccountSettingsLive, :edit
      live "/accounts/settings/confirm_email/:token", AccountSettingsLive, :confirm_email
    end
  end

  scope "/", CoreWeb do
    pipe_through [:browser]

    delete "/accounts/log_out", AccountSessionController, :delete

    live_session :current_account,
      on_mount: [{CoreWeb.AccountAuth, :mount_current_account}] do
      live "/", PageLive, :home
      live "/accounts/confirm/:token", AccountConfirmationLive, :edit
      live "/accounts/confirm", AccountConfirmationInstructionsLive, :new
      live "/aliments", AlimentLive.Index, :index
      live "/aliments/new", AlimentLive.Index, :new
      live "/aliments/:id/edit", AlimentLive.Index, :edit
      live "/aliments/:id", AlimentLive.Show, :show
      live "/aliments/:id/show/edit", AlimentLive.Show, :edit
      live "/medications", MedicationLive.Index, :index
      live "/medications/new", MedicationLive.Index, :new
      live "/medications/:id/edit", MedicationLive.Index, :edit
      live "/medications/:id", MedicationLive.Show, :show
      live "/medications/:id/show/edit", MedicationLive.Show, :edit
      live "/entries", EntryLive.Index, :index
      live "/entries/new", EntryLive.Index, :new
      live "/entries/:id/edit", EntryLive.Index, :edit
      live "/entries/:id", EntryLive.Show, :show
      live "/entries/:id/show/edit", EntryLive.Show, :edit
      live "/treatments", TreatmentLive.Index, :index
      live "/treatments/new", TreatmentLive.Index, :new
      live "/treatments/:id/edit", TreatmentLive.Index, :edit
      live "/treatments/:id", TreatmentLive.Show, :show
      live "/treatments/:id/show/edit", TreatmentLive.Show, :edit
    end
  end
end
