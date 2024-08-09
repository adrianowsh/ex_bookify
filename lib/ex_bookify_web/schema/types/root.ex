defmodule ExBookifyWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias ExBookifyWeb.Resolvers.Vacation, as: VacationResolver

  import_types(ExBookifyWeb.Schema.Types.Booking)
  import_types(ExBookifyWeb.Schema.Types.Place)
  import_types(ExBookifyWeb.Schema.Types.Review)
  import_types(ExBookifyWeb.Schema.Types.User)

  @desc "Queries availables"
  object :root_query do
    @desc "Get a place by its slug"
    field :place, type: :place do
      arg(:slug, non_null(:string))
      resolve(&VacationResolver.place/3)
    end

    @desc "Get a list of places"
    field :places, list_of(:place) do
      arg(:limit, type: :integer)
      arg(:order, type: :sort_order, default_value: :asc)
      arg(:filter, :place_filter)
      resolve(&VacationResolver.places/3)
    end
  end
end
