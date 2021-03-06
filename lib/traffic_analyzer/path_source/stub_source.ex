defmodule TrafficAnalyzer.PathSource.StubSource do
  alias TrafficAnalyzer.PathData
  alias TrafficAnalyzer.PathSource.Source

  @behaviour Source

  def observable_paths do
    [
      %PathData{
        key: "test",
        lat_start: 50.521652,
        lng_start: 30.129102,
        lat_end: 50.500884,
        lng_end: 30.500958
      }
    ]
  end
end
