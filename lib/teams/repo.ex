defmodule Teams.Repo do
  use AshPostgres.Repo,otp_app: :teams

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end

end
