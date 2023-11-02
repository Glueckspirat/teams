defmodule Teams.Auth.Guardian do
  use Guardian, otp_app: :teams

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = Teams.UserManagement.get_user!(id)
    {:ok, resource}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
