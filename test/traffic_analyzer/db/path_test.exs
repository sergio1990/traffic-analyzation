defmodule TrafficAnalyzer.DB.PathTest do
  use TestCaseWithDbSandbox

  alias TrafficAnalyzer.DB.Path

  test "with_key adds the condition by the key field" do
    query = Path.with_key("123")
    # I want somehow check that the where condition by the `key` field has been added
    # by calling `Path.with_key/1`.
    # Maybe there is another approach to check w/o doing the real DB request?
    %Ecto.Query{wheres: [wheres]} = query
    %Ecto.Query.BooleanExpr{params: [{value, {_, field}}]} = wheres
    assert "123" = value
    assert :key = field
  end
end
