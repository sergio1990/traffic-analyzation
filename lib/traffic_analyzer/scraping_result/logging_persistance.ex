require Logger

defmodule TrafficAnalyzer.ScrapingResult.LoggingPersistance do
  alias TrafficAnalyzer.ScrapingResult.Persistance

  @behaviour Persistance

  def save(result) do
    Logger.debug(fn ->
      "Attempt to save the next result: #{inspect(result)}"
    end)
  end
end
