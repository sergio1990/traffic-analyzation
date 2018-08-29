defmodule TrafficAnalyzer.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      worker(TrafficAnalyzer.Scheduler, []),
      TrafficAnalyzer.DB.Repo
    ]

    opts = [strategy: :one_for_one, name: TrafficAnalyzer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
