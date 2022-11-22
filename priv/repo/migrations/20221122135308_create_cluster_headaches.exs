defmodule Core.Repo.Migrations.CreateClusterHeadaches do
  use Ecto.Migration

  def change do
    create table(:cluster_headaches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end
  end
end
