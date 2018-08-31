require Logger

defmodule TrafficAnalyzer.DelayedWork.FakeEnqueuer do
  alias TrafficAnalyzer.DelayedWork.JobEnqueuer

  @behaviour JobEnqueuer

  def enqueue(job_module, args) do
    Logger.debug(fn ->
      "Attempt to enqueue the job: #{job_module} with args #{inspect(args)}"
    end)
  end
end
