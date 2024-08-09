defmodule ExBookifyWeb.Schema.Schema do
  use Absinthe.Schema

  alias ExBookify.Accounts
  alias ExBookify.Vacation

  import_types(Absinthe.Type.Custom)
  import_types(ExBookifyWeb.Schema.Types.Root)

  query do
    import_fields(:root_query)
  end

  # mutation do
  #   # import_fields :root_mutation
  # end

  # subscription do
  #   # import_fields :root_subscription
  # end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Vacation, Vacation.datasource())
      |> Dataloader.add_source(Accounts, Accounts.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
