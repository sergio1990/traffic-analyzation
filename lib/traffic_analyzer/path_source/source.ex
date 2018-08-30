defmodule TrafficAnalyzer.PathSource.Source do
  alias TrafficAnalyzer.PathData

  @callback observable_paths() :: [PathData.t]
end
