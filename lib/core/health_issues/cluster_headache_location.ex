defmodule Core.HealthIssues.ClusterHeadacheLocation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cluster_headache_locations" do
    field :intensity, :integer
    field :radius, :integer
    field :x, :integer
    field :y, :integer
    belongs_to :cluster_headache, Core.HealthIssues.ClusterHeadache

    timestamps()
  end

  @doc false
  def changeset(cluster_headache_location, attrs) do
    cluster_headache_location
    |> cast(attrs, [:x, :y, :intensity, :radius])
    |> validate_required([:x, :y, :intensity, :radius])
    |> put_assoc(:cluster_headache, attrs[:cluster_headache])
  end
end
