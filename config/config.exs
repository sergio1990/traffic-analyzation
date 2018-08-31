use Mix.Config

config :logger,
  backends: [:console],
  level: :debug

config :traffic_analyzer, TrafficAnalyzer.Scheduler,
  jobs: [
    {"* * * * *", fn -> require Logger; Logger.debug("quantum heartbeat...") end},
    {"* * * * *", {TrafficAnalyzer.JobService, :call, []}}
  ]

config :traffic_analyzer,
  path_source: TrafficAnalyzer.PathSource.StubSource,
  result_persistance: TrafficAnalyzer.ScrapingResult.CSVPersistance,
  job_enqueuer: TrafficAnalyzer.DelayedWork.ExqEnqueuer,
  directions_api_client: TrafficAnalyzer.DirectionsApi.GmapsClient,
  ecto_repos: [TrafficAnalyzer.DB.Repo]

config :exq,
  name: Exq,
  host: "<REDIS-HOST>",
  port: 6379,
  namespace: "exq",
  concurrency: :infinite,
  queues: ["default"],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 25,
  shutdown_timeout: 5000

config :google_maps,
  api_key: "<API-KEY>"

config :traffic_analyzer, TrafficAnalyzer.DB.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "traffic_analyzer",
  username: "traffic_analyzer",
  password: "traffic_analyzer",
  hostname: "localhost",
  port: 5432

import_config "#{Mix.env()}.secret.exs"
