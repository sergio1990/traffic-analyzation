defmodule TrafficAnalyzer.Factory do
  use ExMachina.Ecto, repo: TrafficAnalyzer.DB.Repo

  alias TrafficAnalyzer.DB.{Path}

  def path_factory do
    %Path{
      key: Faker.Internet.user_name(),
      lat_start: Faker.Address.latitude(),
      lat_end: Faker.Address.latitude(),
      lng_start: Faker.Address.longitude(),
      lng_end: Faker.Address.longitude()
    }
  end
end
