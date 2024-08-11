defmodule ExBookifyWeb.GraphqlWsSocket do
  use Absinthe.GraphqlWS.Socket, schema: ExBookifyWeb.Schema.Schema
end
