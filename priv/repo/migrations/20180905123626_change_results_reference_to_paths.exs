defmodule TrafficAnalyzer.DB.Repo.Migrations.ChangeResultsReferenceToPaths do
  use Ecto.Migration

  def change do
    alter table(:results) do
      remove :path_key
      add :path_id, references("paths")
    end
  end
end
