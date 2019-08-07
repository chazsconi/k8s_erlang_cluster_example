defmodule K8SExample.Plug do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, body())
  end

  defp body do
    {:ok, hostname} = :inet.gethostname()

    [
      "Hostname: #{hostname}",
      "Node: #{inspect(Node.self())}",
      "Nodes: #{inspect(Node.list(), pretty: true)}"
    ]
    |> Enum.join("\n")
  end
end
