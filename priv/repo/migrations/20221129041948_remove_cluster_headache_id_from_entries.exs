defmodule Core.Repo.Migrations.RemoveClusterHeadacheIdFromEntries do
  use Ecto.Migration

  def change do
    alter table(:treatments) do
      remove :cluster_headache_id
    end
  end
end
