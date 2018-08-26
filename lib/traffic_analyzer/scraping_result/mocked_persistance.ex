require Logger

defmodule TrafficAnalyzer.ScrapingResult.MockedPersistance do
  alias TrafficAnalyzer.ScrapingResult.{Persistance, Result}

  @behaviour Persistance

  def save(result) do
    Logger.debug("Attempt to save the next result: #{inspect(result)}")   
  end
end
