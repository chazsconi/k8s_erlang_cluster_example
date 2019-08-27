defmodule K8SExample.Application do
  require Logger
  @moduledoc false

  use Application

  def start(_type, _args) do
    Logger.info("Starting app")

    # topologies = [
    #   example: [
    #     strategy: Cluster.Strategy.Epmd,
    #     config: [
    #       hosts: [
    #         :"node@k8s-example-statefulset-0.k8s-example-erlang-cluster.default.svc.cluster.local",
    #         :"node@k8s-example-statefulset-1.k8s-example-erlang-cluster.default.svc.cluster.local",
    #         :"node@k8s-example-statefulset-2.k8s-example-erlang-cluster.default.svc.cluster.local"
    #       ]
    #     ]
    #   ]
    # ]

    topologies = [
      example: [
        strategy: Cluster.Strategy.Kubernetes.DNS,
        config: [
          service: "k8s-example-erlang-cluster.default.svc.cluster.local",
          application_name: "node",
          polling_interval: 10_000
        ]
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: K8SExample.ClusterSupervisor]]},
      {Plug.Cowboy, scheme: :http, plug: K8SExample.Plug, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: K8SExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
