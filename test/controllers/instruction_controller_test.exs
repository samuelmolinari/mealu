defmodule Mealu.InstructionControllerTest do
  use Mealu.ConnCase
  import Mealu.Factory

  test "#create creates a new recipe instruction" do
    recipe = insert(:recipe)

    conn = build_conn()
    conn = post conn, recipe_instruction_path(conn, :create, recipe), %{text: "Test instruction"}

    instruction = json_response(conn, 200)["instruction"]

    assert instruction["recipe_id"] == recipe.id
    assert instruction["text"] == "Test instruction"
    assert instruction["position"] == 1
  end

  test "#create automatically increase the position value" do
    instruction = insert(:instruction)

    conn = build_conn()
    conn = post conn, recipe_instruction_path(conn, :create, instruction.recipe), %{text: "Test instruction"}

    assert json_response(conn, 200)["instruction"]["position"] == 2
  end

  test "#update update instruction" do
    instruction = insert(:instruction)

    conn = build_conn()
    conn = put conn, recipe_instruction_path(conn, :update, instruction.recipe, instruction), %{text: "Updated test instruction"}

    assert json_response(conn, 200)["instruction"]["text"] == "Updated test instruction"
  end

  test "#reorder update instructions orders" do
    recipe = insert(:recipe)
    i1 = insert(:instruction, position: 1, recipe: recipe)
    i2 = insert(:instruction, position: 2, recipe: recipe)
    i3 = insert(:instruction, position: 3, recipe: recipe)

    conn = build_conn()
    conn = patch conn, recipe_instruction_path(conn, :reorder, recipe), ids: [i2.id, i3.id, i1.id]

    response(conn, 200)

    assert Repo.get(Mealu.Instruction, i1.id).position == 3
    assert Repo.get(Mealu.Instruction, i2.id).position == 1
    assert Repo.get(Mealu.Instruction, i3.id).position == 2
  end
end
