require Logger

defmodule TrafficAnalyzer.JobService do
  def call do
    observable_paths = path_source().observable_paths()
    Logger.debug("Available path to be observable: #{inspect(observable_paths)}")
  end

  defp path_source do
    Application.get_env(:traffic_analyzer, :path_source)
  end
end
