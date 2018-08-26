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
  result_persistance: TrafficAnalyzer.ScrapingResult.MockedPersistance

config :exq,
  name: Exq,
  host: "127.0.0.1",
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
  api_key: "<API_KEY>"
# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :traffic_analyzer, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:traffic_analyzer, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"
