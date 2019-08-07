defmodule K8SExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :k8s_example,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {K8SExample.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:distillery, "~> 2.1"},
      {:libcluster, "~> 3.1"}
    ]
  end
end
