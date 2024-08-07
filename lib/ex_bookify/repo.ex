defmodule ExBookify.Repo do
  use Ecto.Repo,
    otp_app: :ex_bookify,
    adapter: Ecto.Adapters.Postgres
end
