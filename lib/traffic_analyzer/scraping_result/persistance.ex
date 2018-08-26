defmodule TrafficAnalyzer.ScrapingResult.Persistance do
  alias TrafficAnalyzer.ScrapingResult.Result

  @callback save(Result.t) :: none()
end
