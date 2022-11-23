defmodule Core.HealthIssues.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "entries" do
    field :context, :string
    field :severity, :integer
    field :radius, :integer
    field :x, :integer
    field :y, :integer
    field :note, :string
    belongs_to :cluster_headache, Core.HealthIssues.ClusterHeadache, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:context, :severity, :x, :y, :radius, :note])
    |> put_assoc(:cluster_headache, attrs["cluster_headache"])
    |> validate_required([:context, :severity, :x, :y, :radius, :cluster_headache])
    |> foreign_key_constraint(:cluster_headache_id)
  end
end
