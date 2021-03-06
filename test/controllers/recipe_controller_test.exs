defmodule Mealu.RecipeControllerTest do
  use Mealu.ConnCase
  import Mealu.Factory

  test "#create insert a new recipe" do
    conn = build_conn()
    conn = post conn,
                recipe_path(conn, :create),
                %{name: "Test recipe",
                  preparation_time: 10,
                  cooking_time: 20,
                  serves: 1}

    response = json_response(conn, 201)

    assert response["recipe"]["name"] == "Test recipe"
  end

  test "#create invalid recipe" do
    conn = build_conn()
    conn = post conn,
                recipe_path(conn, :create),
                %{name: "Test recipe",
                  preparation_time: 10,
                  cooking_time: 20}

    response = json_response(conn, 400)

    assert response == %{"errors" => %{"invalid" => [%{"field" => "serves", "message" => "can't be blank"}]}}
  end

  test "#show get recipe" do
    recipe = insert(:recipe)

    conn = build_conn()
    conn = get conn,
               recipe_path(conn, :show, recipe)

    json_recipe = json_response(conn, 200)["recipe"]

    assert json_recipe["id"] == recipe.id
  end
end
