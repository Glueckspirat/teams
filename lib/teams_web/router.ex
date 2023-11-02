defmodule TeamsWeb.Router do
  use TeamsWeb, :router

  pipeline :auth do
    plug Teams.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug Teams.Auth.UserPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TeamsWeb do
    pipe_through [:api, :auth]
    get "/", HelloController, :index
    post "/users/login", UserController, :login
    post "/users/register", UserController, :register
  end

  scope "/api", TeamsWeb do
    pipe_through [:api, :auth, :ensure_auth]
    get "/protected", HelloController, :protected
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:teams, :dev_routes) do

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
