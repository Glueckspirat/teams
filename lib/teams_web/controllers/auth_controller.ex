defmodule TeamsWeb.AuthController do
  use TeamsWeb, :controller

  def register(conn, %{"username" => username, "password" => password, "password_confirmation" => password_confirmation}) do
    try do
      user = Teams.Account.User.register!(username, password, password_confirmation)
      json conn, %{created: true, username: user.username}
    rescue
      e in Ash.Error.Invalid ->
        case Enum.find(e.errors, &(&1.__struct__ == Ash.Error.Changes.InvalidAttribute)) do
          nil -> json conn, %{created: false, msg: "unhandled error"}
          error -> json conn, %{created: false, msg: Ash.Error.Changes.InvalidAttribute.message(error)}
        end
        case Enum.find(e.errors, &(&1.__struct__ == Ash.Error.Changes.InvalidArgument)) do
          nil -> json conn, %{created: false, msg: "unhandled error"}
          error -> json conn, %{created: false, msg: Ash.Error.Changes.InvalidArgument.message(error)}
        end
      _ ->
        json conn, %{created: false, msg: "unhandled error"}
    end
  end

  def login(conn, %{"username" => username, "passsword" => password}) do

  end
end
