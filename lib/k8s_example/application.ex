defmodule K8SExample.Application do
  require Logger
  @moduledoc false

  use Application

  def start(_type, _args) do
    Logger.info("Starting app")

    children = [
      {Plug.Cowboy, scheme: :http, plug: K8SExample.Plug, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: K8SExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
