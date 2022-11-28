defmodule Core.HealthIssues.Treatment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime]
  schema "treatments" do
    field :dosage, :string
    belongs_to :medication, Core.Healthcares.Medication
    belongs_to :cluster_headache, Core.HealthIssues.ClusterHeadache

    timestamps()
  end

  @doc false
  def changeset(treatment, attrs) do
    treatment
    |> cast(attrs, [:dosage, :medication_id])
    |> put_assoc(:cluster_headache, attrs["cluster_headache"])
    |> validate_required([:dosage, :medication_id, :cluster_headache])
    |> foreign_key_constraint(:cluster_headache_id)
    |> foreign_key_constraint(:medication_id)
  end
end
