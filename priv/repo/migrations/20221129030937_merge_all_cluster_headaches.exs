defmodule Core.Repo.Migrations.MergeAllClusterHeadaches do
  use Ecto.Migration

  def change do
    {:ok, aliment} =
      Core.HealthIssues.create_aliment(%{
        name: "Cluster Headache"
      })

    alter table(:entries) do
      add :aliment_id,
          references(:aliments, on_delete: :nothing, type: :binary_id)
    end

    create index(:entries, [:aliment_id])

    flush()

    for entry <- Core.HealthIssues.list_entries() do
      Core.HealthIssues.update_entry(entry, %{aliment_id: aliment.id})
    end

    alter table(:entries) do
      remove :cluster_headache_id
    end
  end
end
