defmodule Mealu.RecipeIngredientTest do
  use Mealu.ModelCase

  alias Mealu.RecipeIngredient

  @valid_attrs %{notes: "some content", quantity: 42, unit: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RecipeIngredient.changeset(%RecipeIngredient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RecipeIngredient.changeset(%RecipeIngredient{}, @invalid_attrs)
    refute changeset.valid?
  end
end
