defmodule Teams.Account.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "users"

    repo Teams.Repo
  end

  code_interface do
    define_for Teams.Account
    define :read_all, action: :read
    define :update, action: :update
    define :destroy, action: :destroy
    define :get_by_id, args: [:id], action: :by_id
    define :register, args: [:username, :password, :password_confirmation]
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    read :by_id do
      argument :id, :uuid, allow_nil?: false

      get? true

      filter expr(id == ^arg(:id))
    end

    create :register do
      primary? true
      accept [:username]

      argument :password, :string, allow_nil?: false
      argument :password_confirmation, :string, allow_nil?: false

      validate confirm(:password, :password_confirmation)

      change fn changeset, _ ->
        case Ash.Changeset.fetch_argument(changeset, :password) do
          {:ok, value} ->
            hash = Bcrypt.hash_pwd_salt(value)
            Ash.Changeset.change_attribute(changeset, :password_hash, hash)
          :error -> changeset
        end
      end
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :username, :string do
      allow_nil? false
    end

    attribute :password_hash, :string do
      allow_nil? false
    end


  end
end
