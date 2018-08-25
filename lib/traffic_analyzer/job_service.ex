require Logger

defmodule TrafficAnalyzer.JobService do
  def call do
    observable_paths = path_source().observable_paths()
    Logger.debug("Available path to be observable: #{inspect(observable_paths)}")
    Enum.each(observable_paths, fn(path) -> enqueue_job_for(path) end)
  end

  defp path_source do
    Application.get_env(:traffic_analyzer, :path_source)
  end

  defp enqueue_job_for(path) do
    Exq.enqueue(Exq, "default", TrafficAnalyzer.TrafficScraperJob, [path])
  end
end
