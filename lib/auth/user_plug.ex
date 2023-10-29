defmodule Teams.Auth.UserPlug do
  import Plug.Conn

  def init(options) do
    options
  end
  def call(conn, _options) do
    user = Guardian.Plug.current_resource(conn)
    assign(conn, :user, user)
  end
end
