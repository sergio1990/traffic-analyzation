require Logger

defmodule TrafficAnalyzer.ScrapingResult.MockedPersistance do
  alias TrafficAnalyzer.ScrapingResult.{Persistance, Result}

  @behaviour Persistance

  def save(result) do
    Logger.debug(fn ->
      "Attempt to save the next result: #{inspect(result)}"
    end)
  end
end
