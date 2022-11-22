defmodule Core.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :context, :text, null: false
      add :severity, :integer, null: false
      add :x, :integer, null: false
      add :y, :integer, null: false
      add :radius, :integer, null: false

      add :cluster_headache_id,
          references(:cluster_headaches, on_delete: :nothing, type: :binary_id),
          null: false

      timestamps()
    end

    create index(:entries, [:cluster_headache_id])
  end
end
