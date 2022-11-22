defmodule Core.Healthcares.Medication do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "medications" do
    field :name, :string
    field :cooldown, :integer
    field :dosage, :string
    has_many :treatments, Core.HealthIssues.Treatment

    timestamps()
  end

  @doc false
  def changeset(medication, attrs) do
    medication
    |> cast(attrs, [:name, :cooldown, :dosage])
    |> validate_required([:name, :cooldown, :dosage])
  end
end
