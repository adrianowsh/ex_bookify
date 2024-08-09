defmodule ExBookifyWeb.Schema.Types.Place do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias ExBookify.Vacation

  @desc "Fields of Place object"
  object :place do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:location, non_null(:string))
    field(:slug, non_null(:string))
    field(:description, non_null(:string))
    field(:max_guests, non_null(:integer))
    field(:pet_friendly, non_null(:boolean))
    field(:pool, non_null(:boolean))
    field(:wifi, non_null(:boolean))
    field(:price_per_night, non_null(:decimal))
    field(:image, non_null(:string))
    field(:image_thumbnail, non_null(:string))

    field :bookings, list_of(:booking) do
      arg(:limit, type: :integer, default_value: 100)
      resolve(dataloader(Vacation, :bookings, args: %{scope: :place}))
    end

    field(:reviews, list_of(:review), resolve: dataloader(Vacation))
  end

  @desc "Filters for the list of places"
  input_object :place_filter do
    @desc "Matching a name, location, or description"
    field(:matching, :string)

    @desc "Has wifi"
    field(:wifi, :boolean)

    @desc "Allows pets"
    field(:pet_friendly, :boolean)

    @desc "Has a pool"
    field(:pool, :boolean)

    @desc "Number of guests"
    field(:guest_count, :integer)

    @desc "Available for booking between a start and end date"
    field(:available_between, :date_range)
  end

  @desc "Start and end dates"
  input_object :date_range do
    field(:start_date, non_null(:date))
    field(:end_date, non_null(:date))
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end
end
