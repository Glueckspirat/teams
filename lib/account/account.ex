defmodule Teams.Account do
  use Ash.Api

  resources do
    registry  Teams.Account.Registry
  end
end
