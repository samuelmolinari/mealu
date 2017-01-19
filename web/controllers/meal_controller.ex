defmodule Mealu.MealController do
  use Mealu.Web, :controller

  alias Mealu.Recipe
  alias Mealu.Meal

  def create(conn, params = %{"recipe_id" => recipe_id}) do
    recipe = Repo.get(Recipe, recipe_id)

    case Repo.insert(Meal.changeset(%Meal{recipe: recipe}, params)) do
      {:ok, meal} -> render(conn, "meal.json", meal: meal)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(Mealu.ErrorView, "invalid.json", changeset: changeset)
    end
  end
end
