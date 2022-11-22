defmodule Core.HealthIssues.ClusterHeadache do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cluster_headaches" do
    belongs_to :account, Core.Users.Account, on_replace: :update
    has_many :entries, Core.HealthIssues.Entry

    timestamps()
  end

  @doc false
  def changeset(cluster_headache, attrs) do
    cluster_headache
    |> cast(attrs, [])
    |> put_assoc(:account, attrs[:account])
    |> validate_required([:account])
    |> foreign_key_constraint(:account_id)
  end
end