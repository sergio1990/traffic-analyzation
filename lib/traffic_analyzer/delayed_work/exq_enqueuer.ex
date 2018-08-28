defmodule TrafficAnalyzer.DelayedWork.ExqEnqueuer do
  alias TrafficAnalyzer.DelayedWork.JobEnqueuer

  @behaviour JobEnqueuer

  def enqueue(job_module, args) do
    Exq.enqueue(Exq, "default", job_module, args)
  end
end
