defmodule Core.HealthIssues.Treatment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime]
  schema "treatments" do
    field :dosage, :string
    belongs_to :medication, Core.Healthcares.Medication

    timestamps()
  end

  @doc false
  def changeset(treatment, attrs) do
    treatment
    |> cast(attrs, [:dosage, :medication_id])
    |> validate_required([:dosage, :medication_id])
    |> foreign_key_constraint(:medication_id)
  end
end
