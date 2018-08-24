defmodule TrafficAnalyzer.PathSource.Source do
  alias TrafficAnalyzer.PathSource.Path

  @callback observable_paths() :: [Path.t]
end
