defmodule ExBookifyWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias ExBookifyWeb.Resolvers.Account, as: AccountResolver
  alias ExBookifyWeb.Resolvers.Vacation, as: VacationResolver
  alias ExBookifyWeb.Schema.Middleware.Authenticate, as: MiddlewareAuthenticate

  import_types(ExBookifyWeb.Schema.Types.Booking)
  import_types(ExBookifyWeb.Schema.Types.Place)
  import_types(ExBookifyWeb.Schema.Types.Review)
  import_types(ExBookifyWeb.Schema.Types.User)
  import_types(ExBookifyWeb.Schema.Types.Session)

  @desc "Queries root"
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

    @desc "Get the currently signed-in user"
    field :me, :user do
      middleware(MiddlewareAuthenticate)
      resolve(&AccountResolver.me/3)
    end
  end

  @desc "Mutations root"
  object :root_mutation do
    @desc "Create a booking for a place"
    field :create_booking, :booking do
      arg(:place_id, non_null(:id))
      arg(:start_date, non_null(:date))
      arg(:end_date, non_null(:date))
      middleware(MiddlewareAuthenticate)
      resolve(&VacationResolver.create_booking/3)
    end

    @desc "Cancel a booking"
    field :cancel_booking, :booking do
      arg(:booking_id, non_null(:id))
      middleware(MiddlewareAuthenticate)
      resolve(&VacationResolver.cancel_booking/3)
    end

    @desc "Create a review lfor a place"
    field :create_review, :review do
      arg(:place_id, non_null(:id))
      arg(:comment, :string)
      arg(:rating, non_null(:integer))
      middleware(MiddlewareAuthenticate)
      resolve(&VacationResolver.create_review/3)
    end

    @desc "Creating user account"
    field :signup, :session do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&AccountResolver.signup/3)
    end

    @desc "Sign in a user"
    field :signin, :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&AccountResolver.signin/3)
    end
  end

  @desc "Subscription root"
  object(:root_subscription) do
    @desc "Subscribe to booking changes for a place"
    field :booking_change, :booking do
      arg(:place_id, non_null(:id))

      config(fn args, _res ->
        {:ok, topic: args.place_id}
      end)
    end
  end
end
