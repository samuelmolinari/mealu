defmodule Mealu.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :serves, :integer
      add :due_at, :utc_datetime
      add :recipe_id, references(:recipes, on_delete: :nothing)

      timestamps()
    end
    create index(:meals, [:recipe_id])
  end
end
