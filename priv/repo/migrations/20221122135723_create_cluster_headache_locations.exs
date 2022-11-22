defmodule Core.Repo.Migrations.CreateClusterHeadacheLocations do
  use Ecto.Migration

  def change do
    create table(:cluster_headache_locations, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :x, :integer,
        null:
          add(:y, :integer,
            null:
              add(:intensity, :integer,
                null:
                  add(:radius, :integer,
                    null:
                      add(
                        :cluster_headache_id,
                        references(:cluster_headaches, on_delete: :nothing, type: :binary_id),
                        null: timestamps()
                      )
                  )
              )
          )
    end

    create index(:cluster_headache_locations, [:cluster_headache_id])
  end
end
