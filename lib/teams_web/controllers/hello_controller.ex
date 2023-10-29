defmodule TeamsWeb.HelloController do
  use TeamsWeb, :controller

  def index(conn, _) do
    text conn, "hello! World!"
  end

  def protected(conn, _) do
    json conn, conn.assigns.user
  end

end
