defmodule Plive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Plive.Release.migrate()

    children = [
      PliveWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:plive, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Plive.PubSub},
      {Plive.Repo, []},

      # Start the Finch HTTP client for sending emails
      {Finch, name: Plive.Finch},
      # Start a worker by calling: Plive.Worker.start_link(arg)
      # {Plive.Worker, arg},
      # Start to serve requests, typically the last entry
      PliveWeb.Endpoint,
      {NodeJS.Supervisor,
       path: Path.join([Application.app_dir(:plive), "priv/og_image_js"]), pool_size: 4}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Plive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PliveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
