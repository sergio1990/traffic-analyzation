use Mix.Config

config :logger,
  backends: [:console, {LoggerFileBackend, :debug_log}],
  level: :debug

config :logger, :debug_log,
  path: "log/debug.log",
  level: :debug

config :traffic_analyzer, TrafficAnalyzer.Scheduler,
  jobs: [
    {"* * * * *", {TrafficAnalyzer.HeartbeatJob, :call, []}},
    {"* * * * *", {TrafficAnalyzer.JobService, :call, []}}
  ]

config :traffic_analyzer,
  path_source: TrafficAnalyzer.PathSource.StubSource,
  result_persistance: TrafficAnalyzer.ScrapingResult.DbPersistance,
  job_enqueuer: TrafficAnalyzer.DelayedWork.ExqEnqueuer,
  directions_api_client: TrafficAnalyzer.DirectionsApi.GmapsClient,
  ecto_repos: [TrafficAnalyzer.DB.Repo]

config :exq,
  name: Exq,
  host: System.get_env("REDIS_HOST"),
  port: System.get_env("REDIS_PORT"),
  namespace: "exq",
  concurrency: :infinite,
  queues: ["default"],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 25,
  shutdown_timeout: 5000

config :google_maps,
  api_key: System.get_env("GMAPS_API_KEY")

config :traffic_analyzer, TrafficAnalyzer.DB.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("DB_NAME"),
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  hostname: System.get_env("DB_HOST"),
  port: System.get_env("DB_PORT")

if File.exists?("#{Mix.env()}.secret.exs") do
  import_config "#{Mix.env()}.secret.exs"
end
