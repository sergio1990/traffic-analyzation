defmodule TrafficAnalyzer.TrafficScraperJobTest do
  use ExUnit.Case, async: true
  import Mox

  alias TrafficAnalyzer.{DataFactory, ResultData}
  alias TrafficAnalyzer.TrafficScraperJob

  alias TrafficAnalyzer.DirectionsApi.MockClient
  alias TrafficAnalyzer.ScrapingResult.MockPersistance

  setup :verify_on_exit!

  test "perform saves result in a case of success gmaps response" do
    path = DataFactory.build(:path_map)
    directions_response = DataFactory.build(:success_directions_response)
    MockClient |> expect(:directions, fn(_, _, _) -> {:ok, directions_response} end)
    MockPersistance |> expect(:save, fn(%ResultData{}) -> :ok end)
    TrafficScraperJob.perform(path)
  end

  test "perform does save nothing in a case of failure gmaps response" do
    path = DataFactory.build(:path_map)
    MockClient |> expect(:directions, fn(_, _, _) -> {:error, "The GMaps is down!"} end)
    MockPersistance |> expect(:save, 0, fn(%ResultData{}) -> :ok end)
    TrafficScraperJob.perform(path)
  end
end
