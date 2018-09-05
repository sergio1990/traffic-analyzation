defmodule TrafficAnalyzer.DB.Result do
  use Ecto.Schema

  schema "results" do
    field :description, :string
    field :distance, :integer
    field :duration_in_traffic, :integer
    belongs_to :path, TrafficAnalyzer.DB.Path
    field :start_address, :string
    field :end_address, :string

    timestamps()
  end
end
