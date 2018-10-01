require Logger

defmodule TrafficAnalyzer.HeartbeatJob do
  @paths_source_client Application.get_env(:traffic_analyzer, :path_source)
  @job_enqueuer Application.get_env(:traffic_analyzer, :job_enqueuer)

  def call do
    Logger.debug(fn ->
      "quantum heartbeat..."
    end)
  end
end
