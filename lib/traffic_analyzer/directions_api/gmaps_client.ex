defmodule TrafficAnalyzer.DirectionsApi.GmapsClient do
  @behaviour TrafficAnalyzer.DirectionsApi.Client

  def directions(origin, destination, options) do
    case GoogleMaps.directions(origin, destination, options) do
      {:ok, response} -> {:ok, response}
      {:error, status, error_message} -> {:error, "#{status} - #{error_message}"}
    end
  end
end
