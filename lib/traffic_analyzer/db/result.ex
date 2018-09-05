defmodule TrafficAnalyzer.DB.Result do
  use Ecto.Schema
  import Ecto.Changeset

  schema "results" do
    field :description, :string
    field :distance, :integer
    field :duration_in_traffic, :integer
    belongs_to :path, TrafficAnalyzer.DB.Path
    field :start_address, :string
    field :end_address, :string

    timestamps()
  end

  def changeset(result, params \\ %{}) do
    result
    |> cast(result, [:description, :distance, :duration_in_traffic, :path_id, :start_address, :end_address])
    |> validate_required([:description, :distance, :duration_in_traffic, :start_address, :end_address])
    |> assoc_constraint(:path)
  end
end
