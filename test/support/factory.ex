defmodule TrafficAnalyzer.Factory do
  use ExMachina.Ecto, repo: TrafficAnalyzer.DB.Repo

  alias TrafficAnalyzer.Repo.{Path}

  def factory(:path) do
    %Path{
      key: Faker.Internet.user_name(),
      lat_start: random_coord(),
      lat_end: random_coord(),
      lng_start: random_coord(),
      lng_end: random_coord()
    }
  end

  defp random_coord do
    Kernel.rand * 180.0
  end
end
