defmodule Core.Repo.Migrations.CreateMedications do
  use Ecto.Migration

  def change do
    create table(:medications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text
      add :dosage, :text
      add :cooldown, :integer

      timestamps()
    end
  end
end
