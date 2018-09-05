defmodule TrafficAnalyzer.DB.Repo.Migrations.CreateResults do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :description, :text
      add :distance, :integer
      add :duration_in_traffic, :integer
      add :path_key, references("paths", [column: :key, type: :string])
      add :start_address, :text
      add :end_address, :text

      timestamps()
    end
  end
end
