defmodule ExBookify.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExBookifyWeb.Telemetry,
      ExBookify.Repo,
      {DNSCluster, query: Application.get_env(:ex_bookify, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExBookify.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ExBookify.Finch},
      # Start a worker by calling: ExBookify.Worker.start_link(arg)
      # {ExBookify.Worker, arg},
      # Start to serve requests, typically the last entry
      ExBookifyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExBookify.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExBookifyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
