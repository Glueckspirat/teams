defmodule Teams.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :teams,
    error_handler: Teams.Auth.ErrorHandler,
    module: Teams.Auth.Guardian

    plug Guardian.Plug.VerifyHeader, claims: %{"type" => "access"}
    plug Guardian.Plug.LoadResource, allow_blank: true
end
