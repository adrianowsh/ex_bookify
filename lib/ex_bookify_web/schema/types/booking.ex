defmodule ExBookifyWeb.Schema.Types.Booking do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias ExBookify.Vacation

  @desc "Booking fields object"
  object :booking do
    field(:id, non_null(:id))
    field(:start_date, non_null(:date))
    field(:end_date, non_null(:date))
    field(:state, non_null(:string))
    field(:total_price, non_null(:decimal))
    field(:user, non_null(:user), resolve: dataloader(Vacation))
    field(:place, non_null(:place), resolve: dataloader(Vacation))
  end
end
