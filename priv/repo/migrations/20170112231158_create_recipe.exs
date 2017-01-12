defmodule Mealu.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :preparation_time, :integer
      add :cooking_time, :integer
      add :serves, :integer

      timestamps()
    end

  end
end
