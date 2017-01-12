defmodule Mealu.RecipeView do
  use Mealu.Web, :view

  def render("recipe.json", %{recipe: recipe}) do
    %{
      recipe: recipe_json(recipe)
    }
  end

  def recipe_json(recipe) do
    %{
      name: recipe.name
    }
  end
end
