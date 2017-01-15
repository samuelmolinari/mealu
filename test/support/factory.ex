defmodule Mealu.Factory do
  use ExMachina.Ecto, repo: Mealu.Repo

  def recipe_factory do
    %Mealu.Recipe{
      name: "Factory recipe",
      preparation_time: 60,
      cooking_time: 120,
      serves: 2
    }
  end

  def ingredient_factory do
    %Mealu.Ingredient{
      name: "Factory ingredient"
    }
  end

  def recipe_ingredient_factory do
    %Mealu.RecipeIngredient{
      recipe: build(:recipe),
      ingredient: build(:ingredient),
      quantity: 1,
      unit: :kg,
      notes: "Factory note"
    }
  end
end
