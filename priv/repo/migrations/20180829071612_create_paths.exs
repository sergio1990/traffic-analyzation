defmodule TrafficAnalyzer.DB.Repo.Migrations.CreatePaths do
  use Ecto.Migration

  def change do
    create table("paths") do
      add :key, :string
      add :lat_start, :float
      add :lng_start, :float
      add :lat_end, :float
      add :lng_end, :float

      timestamps()
    end

    create unique_index("paths", [:key])
  end
end
