defmodule TrafficAnalyzer.ScrapingResult.Result do
  defstruct [
    :description,
    :distance,
    :duration_in_traffic,
    :path_key,
    :start_address,
    :end_address,
    :scraped_at
  ]
end
