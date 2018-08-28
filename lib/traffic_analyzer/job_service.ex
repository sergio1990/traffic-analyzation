require Logger

defmodule TrafficAnalyzer.JobService do
  @paths_source_client Application.get_env(:traffic_analyzer, :path_source)
  @job_enqueuer Application.get_env(:traffic_analyzer, :job_enqueuer)

  def call do
    observable_paths = @paths_source_client.observable_paths()
    Logger.debug(fn ->
      "Available path to be observable: #{inspect(observable_paths)}"
    end)
    Enum.each(observable_paths, fn(path) -> enqueue_job_for(path) end)
  end

  defp enqueue_job_for(path) do
    @job_enqueuer.enqueue(TrafficAnalyzer.TrafficScraperJob, [path])
  end
end
