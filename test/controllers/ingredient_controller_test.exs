defmodule Mealu.IngredientControllerTest do
  use Mealu.ConnCase
  import Mealu.Factory

  test "#create insert an ingredient into a recipe" do
    recipe = insert(:recipe)

    conn = build_conn()
    conn = post conn,
                recipe_ingredient_path(conn, :create, recipe),
                %{ingredient: %{
                    name: "Test ingredient"
                  },
                  quantity: 9,
                  unit: "kg",
                  notes: "Test notes"}

    recipe_ingredient = json_response(conn, 200)["recipe_ingredient"]

    assert recipe_ingredient["recipe_id"] == recipe.id
    assert recipe_ingredient["ingredient_id"] != nil
    assert recipe_ingredient["ingredient"]["name"] == "Test ingredient"
    assert recipe_ingredient["quantity"] == 9
    assert recipe_ingredient["unit"] == "kg"
    assert recipe_ingredient["notes"] == "Test notes"
  end

  test "#create find and insert an ingredient into a recipe if it already exists" do
    recipe = insert(:recipe)
    ingredient = insert(:ingredient)

    conn = build_conn()
    conn = post conn,
                recipe_ingredient_path(conn, :create, recipe),
                %{ingredient: %{
                    name: ingredient.name
                  },
                  quantity: 9,
                  unit: "kg",
                  notes: "Test notes"}

    recipe_ingredient = json_response(conn, 200)["recipe_ingredient"]

    assert recipe_ingredient["ingredient_id"] == ingredient.id
  end

  test "#create invalid recipe ingredient" do
    recipe = insert(:recipe)

    conn = build_conn()
    conn = post conn,
                recipe_ingredient_path(conn, :create, recipe),
                %{ingredient: %{
                    name: "Test ingredient"
                  },
                  quantity: 9,
                  notes: "Test notes"}

    response = json_response(conn, 400)

    assert response == %{"errors" => %{"invalid" => [%{"field" => "unit", "message" => "can't be blank"}]}}
  end

  test "#destroy delete a ingredient from a recipe" do
    recipe_ingredient = insert(:recipe_ingredient)

    conn = build_conn()
    conn = delete conn,
                  recipe_ingredient_path(conn, :delete, recipe_ingredient.recipe, recipe_ingredient.ingredient)

    assert json_response(conn, 200) == %{"ok" => true}
    assert Repo.get(Mealu.RecipeIngredient, recipe_ingredient.id) == nil
  end
end
