defmodule Core.Repo.Migrations.CreateClusterHeadacheEntries do
  use Ecto.Migration

  def change do
    create table(:cluster_headache_entries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :context, :text, null: false

      add :cluster_headache_id,
          references(:cluster_headaches, on_delete: :nothing, type: :binary_id),
          null: false

      timestamps()
    end

    create index(:cluster_headache_entries, [:cluster_headache_id])
  end
end
