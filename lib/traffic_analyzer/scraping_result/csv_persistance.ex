require Logger

defmodule TrafficAnalyzer.ScrapingResult.CSVPersistance do
  alias TrafficAnalyzer.ScrapingResult.Persistance

  @behaviour Persistance

  @attributes ["path_key", "description", "distance", "duration_in_traffic", "start_address", "end_address", "scraped_at"]

  def save(result) do
    Logger.debug(fn ->
      "Attempt to save the next result: #{inspect(result)}"
    end)
    file_path = prepare_file_for_results()
    write_result(file_path, result)
  end

  defp prepare_file_for_results do
    file_path = resolve_file_path()
    ensure_file_exists(file_path)
    file_path
  end

  defp write_result(file_path, result) do
    result_row = @attributes
                 |> Enum.map(&(Map.get(result, String.to_atom(&1))))
                 |> Enum.join(";")
    File.write(file_path, "#{result_row}\n", [:append])
  end

  defp resolve_file_path do
    root_path = File.cwd!
    Path.join(root_path, "results.csv")
  end

  defp ensure_file_exists(file_path) do
    unless File.exists?(file_path) do
      File.write(file_path, "#{prepare_headers_row()}\n")
    end
  end

  defp prepare_headers_row do
    Enum.join(@attributes, ";")
  end
end
