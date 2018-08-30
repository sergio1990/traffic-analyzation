defmodule TrafficAnalyzer.ScrapingResult.Persistance do
  alias TrafficAnalyzer.ResultData

  @callback save(ResultData.t) :: none()
end
