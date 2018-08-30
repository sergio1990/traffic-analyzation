defmodule TrafficAnalyzer.Application do
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: TrafficAnalyzer.Supervisor]
    Supervisor.start_link(children(Mix.env), opts)
  end

  defp children(:prod), do: children(:dev)
  defp children(:dev), do: children(:default) ++ [worker(TrafficAnalyzer.Scheduler, [])]
  defp children(_), do: [TrafficAnalyzer.DB.Repo]
end
