defmodule TrafficAnalyzer.TrafficScraperJob do
  require Logger

  alias TrafficAnalyzer.PathSource.Path
  alias TrafficAnalyzer.ScrapingResult.Result

  def perform(path) do
    Logger.debug(fn ->
      "The scraper job is run with #{inspect(path)}"
    end)
    path
    |> make_gmaps_request
    |> process_response
    |> Enum.each(&save_result/1)
  end

  @spec make_gmaps_request(Path.t) :: {binary(), map()}
  defp make_gmaps_request(path) do
    origin = "#{path["lat_start"]},#{path["lng_start"]}"
    destination = "#{path["lat_end"]},#{path["lng_end"]}"
    options = [
      mode: "driving",
      alternatives: true,
      language: "uk",
      departure_time: "now",
      traffic_model: "best_guess"
    ]
    case GoogleMaps.directions(origin, destination, options) do
      {:ok, response} -> {:ok, path["key"], response}
      {:error, status, error_message} -> {:error, "#{status} - #{error_message}"}
    end
  end

  @spec process_response({:ok, binary(), map()} | {:error, binary()}) :: [Result.t] | []
  defp process_response({:ok, path_key, response}) do
    Enum.map(response["routes"], fn(route_map) ->
      result = wrap_route(route_map)
      %{result | path_key: path_key}
    end)
  end
  defp process_response({:error, error_message}) do
    Logger.error(fn ->
      "The GMaps API request failed! Details: #{error_message}"
    end)
    []
  end

  @spec save_result(Result.t) :: none()
  defp save_result(%Result{} = result) do
    persistance = resolve_result_persistance()
    persistance.save(result)
  end

  @spec wrap_route(map()) :: Result.t
  defp wrap_route(route_map) do
    # It means that we have no intermediate points on the way
    leg = Enum.at(route_map["legs"], 0)
    %Result{
      description: route_map["summary"],
      distance: leg["distance"]["value"],
      duration_in_traffic: leg["duration_in_traffic"]["value"],
      start_address: leg["start_address"],
      end_address: leg["end_address"],
      scraped_at: :os.system_time(:seconds)
    }
  end

  defp resolve_result_persistance do
    Application.get_env(:traffic_analyzer, :result_persistance)
  end
end
