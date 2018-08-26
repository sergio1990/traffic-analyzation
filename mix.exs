defmodule TrafficAnalyzer.MixProject do
  use Mix.Project

  def project do
    [
      app: :traffic_analyzer,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex, :exq, :google_maps],
      mod: {TrafficAnalyzer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:quantum, "2.3.2"},
      {:timex, "~> 3.0"},
      {:exq, "~> 0.12.1"},
      {:google_maps, "0.10.0"}
    ]
  end
end
