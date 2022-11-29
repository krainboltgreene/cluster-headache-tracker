defmodule Core.Repo.Migrations.CreateAliments do
  use Ecto.Migration

  def change do
    create table(:aliments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false

      timestamps()
    end
  end
end
