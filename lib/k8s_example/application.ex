defmodule K8SExample.Application do
  require Logger
  @moduledoc false

  use Application

  def start(_type, _args) do
    Logger.info("Starting app")

    children = [
      {Cluster.Supervisor,
       [topologies(System.get_env("CLUSTER_TYPE")), [name: K8SExample.ClusterSupervisor]]},
      {Plug.Cowboy, scheme: :http, plug: K8SExample.Plug, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: K8SExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp topologies("HARDCODED_STATEFULSET") do
    [
      example: [
        strategy: Cluster.Strategy.Epmd,
        config: [
          hosts: [
            :"node@k8s-example-statefulset-0.k8s-example-erlang-cluster.default.svc.cluster.local",
            :"node@k8s-example-statefulset-1.k8s-example-erlang-cluster.default.svc.cluster.local",
            :"node@k8s-example-statefulset-2.k8s-example-erlang-cluster.default.svc.cluster.local"
          ]
        ]
      ]
    ]
  end

  defp topologies(cluster_type) when cluster_type in ["DEPLOYMENT", "DISCOVERED_STATEFULSET"] do
    [
      example: [
        strategy: Cluster.Strategy.Kubernetes.DNSSRV,
        config: [
          service: System.get_env("ERLANG_CLUSTER_SERVICE_NAME"),
          namespace: System.get_env("NAMESPACE"),
          application_name: "node",
          polling_interval: 10_000
        ]
      ]
    ]
  end
end
