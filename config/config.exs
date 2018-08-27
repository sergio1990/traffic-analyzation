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
  path_source: TrafficAnalyzer.PathSource.MockedSource,
  result_persistance: TrafficAnalyzer.ScrapingResult.CSVPersistance

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

import_config "#{Mix.env()}.secret.exs"
