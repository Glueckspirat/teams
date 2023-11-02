defmodule Teams.UserManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Teams.UserManagement` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        username: "some username",
      })
      |> Teams.UserManagement.create_user()

    user
  end
end
