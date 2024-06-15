defmodule BooksApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BooksAppWeb.Telemetry,
      BooksApp.Repo,
      {DNSCluster, query: Application.get_env(:books_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BooksApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BooksApp.Finch},
      # Start a worker by calling: BooksApp.Worker.start_link(arg)
      # {BooksApp.Worker, arg},
      # Start to serve requests, typically the last entry
      BooksAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BooksApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BooksAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
