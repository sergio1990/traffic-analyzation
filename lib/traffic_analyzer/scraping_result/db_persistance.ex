require Logger

defmodule TrafficAnalyzer.ScrapingResult.DbPersistance do
  alias TrafficAnalyzer.ScrapingResult.Persistance
  @behaviour Persistance

  alias TrafficAnalyzer.DB.{Path, Repo, Result}
  alias TrafficAnalyzer.ResultData

  @impl Persistance
  @spec save(ResultData.t) :: :ok | {:error, String.t} | {:error, [{atom, String.t}]}
  def save(result) do
    result
    |> convert_to_changeset
    |> persist
  end

  defp convert_to_changeset(%ResultData{} = result_data) do
    result_params = %{
      description: result_data.description,
      distance: result_data.distance,
      duration_in_traffic: result_data.duration_in_traffic,
      start_address: result_data.start_address,
      end_address: result_data.end_address
    }
    case fetch_path(result_data.path_key) do
      {:ok, path} -> 
        complete_result_params = Map.put(result_params, :path_id, path.id)
        {:ok, Result.changeset(%Result{}, complete_result_params)}
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp persist({:ok, %Ecto.Changeset{} = result_changeset}) do
    case Repo.insert(result_changeset) do
      {:ok, _} -> :ok
      {:error, changeset} ->
        Logger.error("The inserting has been failed! The reason: #{inspect(changeset)}")
        {:error, changeset.errors}
    end
  end
  defp persist({:error, reason}) do
    Logger.error("Could not persist the scraping result into DB! The reason: #{reason}")
    {:error, reason}
  end

  defp fetch_path(key) do
    path = key |> Path.with_key |> Repo.one
    case path do
      %Path{} -> {:ok, path}
      _ -> {:error, "No path with key=`#{key}` found!"}
    end
  end
end
