defmodule TeamsWeb.UserController do
  alias Teams.UserManagement
  use TeamsWeb, :controller

  def login(conn, %{"username" => username, "password" => password}) do
    case UserManagement.athuenticate_user(username, password) do
      {:ok, user} ->
        case Teams.Auth.Guardian.encode_and_sign(user) do
          {:ok, token, _} ->
            conn
            |> put_status(200)
            |> json(%{authenticated: true, token: token})
          {:error, error} ->
            conn
            |> put_status(401)
            |> json(%{authenticated: false, error: error})
        end
      {:error, error} -> conn |> put_status(401) |> json(%{authenticated: false, error: error})
    end
  end

  def register(conn, %{"username" => username, "password" => password, "password_confirmation" => password_confirmation}) do
    if(password == password_confirmation) do
      case UserManagement.create_user(%{username: username, password: password}) do
        {:ok, user} -> conn |> put_status(201) |> json(user)
        {:error, _} -> conn |> put_status(400) |> json(%{error: "couldnt create user"})
      end
    else
      conn |> put_status(400) |> json(%{error: "password doesnt match"})
    end
  end

end
