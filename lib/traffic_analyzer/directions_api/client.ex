defmodule TrafficAnalyzer.DirectionsApi.Client do
  @callback directions(String.t, String.t, keyword()) :: {:ok, map()} | {:error, binary()}
end
