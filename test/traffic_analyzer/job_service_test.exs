defmodule TrafficAnalyzer.JobServiceTest do
  use ExUnit.Case, async: true
  import Mox

  alias TrafficAnalyzer.PathData
  alias TrafficAnalyzer.DataFactory

  setup :verify_on_exit!

  test "#call enqueues a job for each path" do
    TrafficAnalyzer.PathSource.MockSource
    |> expect(:observable_paths, fn -> DataFactory.build_list(2, :path) end)
    TrafficAnalyzer.DelayedWork.MockEnqueuer
    |> expect(:enqueue, 2, fn (TrafficAnalyzer.TrafficScraperJob, [%PathData{}]) -> nil end)
    TrafficAnalyzer.JobService.call
  end
end
