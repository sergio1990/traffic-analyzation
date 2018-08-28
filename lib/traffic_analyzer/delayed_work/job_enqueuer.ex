defmodule TrafficAnalyzer.DelayedWork.JobEnqueuer do
  @callback enqueue(module(), [...]) :: none()
end
