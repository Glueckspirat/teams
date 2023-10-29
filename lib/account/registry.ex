defmodule Teams.Account.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Teams.Account.User
  end

end
