defmodule Core.HealthIssues.ClusterHeadacheEntry do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cluster_headache_entries" do
    field :context, :string
    belongs_to :cluster_headache, Core.HealthIssues.ClusterHeadache

    timestamps()
  end

  @doc false
  def changeset(cluster_headache_entry, attrs) do
    cluster_headache_entry
    |> cast(attrs, [:context])
    |> validate_required([:context])
    |> put_assoc(:cluster_headache, attrs[:cluster_headache])
  end
end
