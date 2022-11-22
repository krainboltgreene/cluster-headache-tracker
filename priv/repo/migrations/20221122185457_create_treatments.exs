defmodule Core.Repo.Migrations.CreateTreatments do
  use Ecto.Migration

  def change do
    create table(:treatments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :dosage, :text, default: ""
      add :medication_id, references(:medications, on_delete: :nothing, type: :binary_id)
      add :cluster_headache_id, references(:cluster_headaches, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:treatments, [:medication_id])
  end
end
