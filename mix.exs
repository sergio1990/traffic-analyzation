defmodule TrafficAnalyzer.MixProject do
  use Mix.Project

  def project do
    [
      app: :traffic_analyzer,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: extra_applications(Mix.env()),
      mod: {TrafficAnalyzer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:quantum, "2.3.2"},
      {:timex, "~> 3.0"},
      {:exq, "~> 0.12.1", runtime: false},
      {:google_maps, "0.10.0", runtime: false},
      {:ecto, "2.2.10"},
      {:postgrex, "0.13.5"},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},
      {:faker, "0.10.0", only: [:test]},
      {:ex_machina, "2.2.0", only: [:test]},
      {:mox, "0.4.0", only: [:test]},
      {:edeliver, "1.6.0"},
      {:distillery, "2.0.10"},
      {:logger_file_backend, "0.0.10"}
    ]
  end

  defp extra_applications(:prod), do: extra_applications(:dev)
  defp extra_applications(:dev), do: extra_applications(:default) ++ [:exq, :google_maps]
  defp extra_applications(:test), do: extra_applications(:default)
  defp extra_applications(_), do: [:logger, :timex, :mix, :poison]

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
