defmodule TrafficAnalyzer.DataFactory do
  use ExMachina

  alias TrafficAnalyzer.PathData

  def path_factory do
    %PathData{
      key: Faker.Internet.user_name(),
      lat_start: random_coord(),
      lat_end: random_coord(),
      lng_start: random_coord(),
      lng_end: random_coord()
    }
  end

  defp random_coord do
    :rand.uniform * 180.0
  end
end
