defmodule SlackAsap do
  @moduledoc """
  Documentation for SlackAsap.
  """

  use Application

  defp children(l),
    do: children(l, [])

  defp children([{:start_server, val}| t], result) do
    newChild = case val do
      true -> [Plug.Adapters.Cowboy.child_spec(
          :http,
          SlackAsap.Router,
          [],
          [port: Application.get_env(:slack_asap, :port)]
      )]
      _ -> []
    end
    children t, (result ++ newChild)
  end

  defp children([{key, val}| _t], _result),
    do: raise(ArgumentError, "invalid option #{inspect key} with value #{inspect val}")

  defp children([], result),
    do: result

  def start(_type, args) do
      opts = [strategy: :one_for_one, name: SlackAsap.Supervisor]
      Supervisor.start_link(children(args), opts)
  end
end
