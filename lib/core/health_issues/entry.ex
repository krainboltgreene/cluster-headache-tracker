defmodule Core.HealthIssues.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime]
  schema "entries" do
    field :context, :string, default: "ongoing"
    field :severity, :integer
    field :radius, :integer, default: 2
    field :x, :integer
    field :y, :integer
    field :note, :string
    belongs_to :aliment, Core.HealthIssues.Aliment, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:context, :severity, :x, :y, :radius, :note, :aliment_id])
    |> validate_required([:context, :severity, :x, :y, :radius, :aliment_id])
    |> foreign_key_constraint(:aliment_id)
  end
end
