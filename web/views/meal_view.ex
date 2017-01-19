defmodule Mealu.MealView do
  use Mealu.Web, :view

  def render("meal.json", %{meal: meal}) do
    %{
      meal: meal_json(meal)
    }
  end

  def meal_json(meal) do
    %{
      id: meal.id,
      serves: meal.serves,
      due_at: meal.due_at,
      recipe_id: meal.recipe_id
    }
  end
end
