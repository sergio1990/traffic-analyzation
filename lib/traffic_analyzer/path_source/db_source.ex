defmodule TrafficAnalyzer.PathSource.DBSource do
  alias TrafficAnalyzer.DB
  alias TrafficAnalyzer.DB.Repo
  alias TrafficAnalyzer.PathSource.Source
  alias TrafficAnalyzer.PathData

  @behaviour Source

  def observable_paths do
    DB.Path
    |> Repo.all
    |> Enum.map(&wrap/1)
  end

  defp wrap(path_record) do
    %PathData{
      key: path_record.key,
      lat_start: path_record.lat_start,
      lng_start: path_record.lng_start,
      lat_end: path_record.lat_end,
      lng_end: path_record.lng_end
    }
  end
end
