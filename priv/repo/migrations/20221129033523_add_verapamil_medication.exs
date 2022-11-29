defmodule Core.Repo.Migrations.AddVerapamilMedication do
  use Ecto.Migration

  def change do
    Core.Healthcares.create_medication(%{name: "Verapamil", dosage: "1 pill", cooldown: -1})
  end
end
