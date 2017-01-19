defmodule Mealu.RecipeView do
  use Mealu.Web, :view

  def render("recipe.json", %{recipe: recipe}) do
    %{
      recipe: recipe_json(recipe)
    }
  end

  def recipe_json(recipe) do
    %{
      id: recipe.id,
      recipes_ingredients: Enum.map(
                             recipe.recipes_ingredients,
                             &Mealu.IngredientView.render_recipe_ingredient/1),
      instructions: Enum.map(recipe.instructions,
                             &Mealu.InstructionView.render_instruction/1),
      name: recipe.name,
      preparation_time: recipe.preparation_time,
      cooking_time: recipe.cooking_time,
      serves: recipe.serves
    }
  end
end
