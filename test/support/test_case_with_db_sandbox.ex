defmodule TestCaseWithDbSandbox do
  @moduledoc """
  Template for ExUnit which provides implicit setup for DB sandbox.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import TrafficAnalyzer.Factory
      alias TrafficAnalyzer.DB.Repo
    end
  end


  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TrafficAnalyzer.DB.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(TrafficAnalyzer.DB.Repo, {:shared, self()})
    :ok
  end
end
