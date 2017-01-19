defmodule Mealu.MealControllerTest do
  use Mealu.ConnCase
  import Mealu.Factory

  test "#create new meal" do
    recipe = insert(:recipe)

    conn = build_conn()
    conn = post conn, recipe_meal_path(conn, :create, recipe), %{due_at: "2017-01-01 00:00:00", serves: 2}

    meal = json_response(conn, 200)["meal"]

    assert meal["id"] != nil
    assert meal["recipe_id"] == recipe.id
    assert meal["due_at"] == "2017-01-01T00:00:00"
    assert meal["serves"] == 2
  end
end
