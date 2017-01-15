defmodule Mealu.IngredientController do
  use Mealu.Web, :controller

  alias Mealu.Recipe
  alias Mealu.Ingredient
  alias Mealu.RecipeIngredient

  def create(conn, params = %{"ingredient" => %{"name" => name}, "recipe_id" => recipe_id}) do
    create(conn, {recipe(recipe_id), Repo.get_by(Ingredient, name: name)}, params)
  end

  defp create(conn, {recipe, nil}, params) do
    changeset = RecipeIngredient.changeset(%RecipeIngredient{
                                           recipe: recipe}, params)
    insert(conn, changeset)
  end

  defp create(conn, {recipe, ingredient}, params) do
    changeset = RecipeIngredient.changeset(%RecipeIngredient{
                                           recipe: recipe,
                                           ingredient: ingredient
                                         }, Map.delete(params, "ingredient"))

    insert(conn, changeset)
  end

  defp insert(conn, changeset = %Ecto.Changeset{}) do
    case Repo.insert(changeset) do
      {:ok, recipe_ingredient} -> render(conn, "recipe_ingredient.json", recipe_ingredient: recipe_ingredient)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(Mealu.ErrorView, "invalid.json", changeset: changeset)
    end
  end

  defp recipe(id) do
    Repo.get(Recipe, id)
  end
end
