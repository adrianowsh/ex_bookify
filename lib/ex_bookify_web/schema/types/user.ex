defmodule ExBookifyWeb.Schema.Types.User do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias ExBookify.Vacation

  @desc "Fields of User object"
  object :user do
    field(:username, non_null(:string))
    field(:email, non_null(:string))
    field(:bookings, list_of(:booking), resolve: dataloader(Vacation))
    field(:reviews, list_of(:review), resolve: dataloader(Vacation))
  end
end
