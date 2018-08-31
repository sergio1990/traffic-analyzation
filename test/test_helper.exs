Mox.defmock(TrafficAnalyzer.PathSource.MockSource, for: TrafficAnalyzer.PathSource.Source)
Mox.defmock(TrafficAnalyzer.DelayedWork.MockEnqueuer, for: TrafficAnalyzer.DelayedWork.JobEnqueuer)
Mox.defmock(TrafficAnalyzer.DirectionsApi.MockClient, for: TrafficAnalyzer.DirectionsApi.Client)

{:ok, _} = Application.ensure_all_started(:ex_machina)

Faker.start()

Ecto.Adapters.SQL.Sandbox.mode(TrafficAnalyzer.DB.Repo, :manual)

ExUnit.start()
