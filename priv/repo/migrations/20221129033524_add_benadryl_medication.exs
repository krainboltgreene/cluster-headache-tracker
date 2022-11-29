defmodule Core.Repo.Migrations.AddBenadrylMedication do
  use Ecto.Migration

  def change do
    Core.Healthcares.create_medication(%{name: "Benadryl", dosage: "1 pill", cooldown: 6})
  end
end
