defmodule TrafficAnalyzer.PathSourceDBSourceTest do
  use TestCaseWithDbSandbox

  alias TrafficAnalyzer.PathSource.DBSource
  alias TrafficAnalyzer.PathData

  test "observable_paths returns all paths contained in the DB" do
    insert(:path)
    paths = DBSource.observable_paths()
    assert Enum.count(paths) == 1
    first_path = Enum.at(paths, 0)
    assert %PathData{} = first_path
  end
end
