defmodule TrafficAnalyzer.DB.Path do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  schema "paths" do
    field :key, :string
    field :lat_start, :float
    field :lng_start, :float
    field :lat_end, :float
    field :lng_end, :float

    timestamps()
  end

  def changeset(path, params \\ %{}) do
    path
    |> cast(params, [:key, :lat_start, :lng_start, :lat_end, :lng_end])
    |> validate_required([:key, :lat_start, :lng_start, :lat_end, :lng_end])
    |> unique_constraint(:key)
  end

  def with_key(query \\ __MODULE__, key) do
    from p in query, where: p.key == ^key
  end
end
