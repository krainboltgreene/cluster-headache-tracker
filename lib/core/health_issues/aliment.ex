defmodule Core.HealthIssues.Aliment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime]
  schema "aliments" do
    field :name, :string
    has_many :entries, Core.HealthIssues.Entry

    timestamps()
  end

  @doc false
  def changeset(aliment, attrs) do
    aliment
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
