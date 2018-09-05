defmodule TrafficAnalyzer.DataFactory do
  use ExMachina

  alias TrafficAnalyzer.PathData

  def path_factory do
    %PathData{
      key: Faker.Internet.user_name(),
      lat_start: Faker.Address.latitude(),
      lat_end: Faker.Address.latitude(),
      lng_start: Faker.Address.longitude(),
      lng_end: Faker.Address.longitude()
    }
  end

  def path_map_factory do
    path_factory()
    |> Map.from_struct
    |> Map.new(fn {k, v} -> {Atom.to_string(k), v} end)
  end

  def success_directions_response_factory do
    %{
      "routes" => [
        %{
          "legs" => [
            %{
              "summary" => Faker.Lorem.sentence,
              "start_address" => Faker.Address.street_address(true),
              "end_address" => Faker.Address.street_address(true),
              "distance" => %{
                "value" => Faker.Random.Elixir.random_between(10, 1000)
              },
              "duration_in_traffic" => %{
                "value" => Faker.Random.Elixir.random_between(10, 1000)
              }
            }
          ]
        }
      ]
    }
  end
end
