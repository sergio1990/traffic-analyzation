defmodule TrafficAnalyzer.ScrapingResult.DbPersistanceTest do
  use TestCaseWithDbSandbox

  alias TrafficAnalyzer.DataFactory
  alias TrafficAnalyzer.ScrapingResult.DbPersistance

  test "#save completes successfully when happy path" do
    path = insert(:path)
    result_data = DataFactory.build(:result, %{path_key: path.key})
    persistence_result = DbPersistance.save(result_data)
    assert :ok = persistence_result
  end

  test "#save completes with error when no such path with a given key" do
    result_data = DataFactory.build(:result, %{path_key: "some-unexisting-key"})
    persistence_result = DbPersistance.save(result_data)
    assert {:error, "No path with" <> _rest_reason} = persistence_result
  end

  test "#save completes with error when the validation errors occur" do
    path = insert(:path)
    result_data = DataFactory.build(:result, %{path_key: path.key, description: nil})
    persistence_result = DbPersistance.save(result_data)
    assert {:error, [description: {"can't be blank", [validation: :required]}]} = persistence_result
  end
end
