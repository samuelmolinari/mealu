defmodule Mealu.IngredientView do
  use Mealu.Web, :view

  def render("recipe_ingredient.json", %{recipe_ingredient: recipe_ingredient}) do
    %{
      recipe_ingredient: render_recipe_ingredient(recipe_ingredient)
    }
  end

  def render_ingredient(ingredient) do
    %{
      name: ingredient.name
    }
  end

  def render_recipe_ingredient(recipe_ingredient) do
    %{
      id: recipe_ingredient.id,
      recipe_id: recipe_ingredient.recipe_id,
      ingredient_id: recipe_ingredient.ingredient_id,
      ingredient: render_ingredient(recipe_ingredient.ingredient)
    }
  end
end
