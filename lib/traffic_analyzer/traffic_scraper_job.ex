defmodule TrafficAnalyzer.TrafficScraperJob do
  require Logger

  def perform(path) do
    Logger.debug("The scraper job is run with #{inspect(path)}") 
  end
end
