defmodule Mealu.RecipeTest do
  use Mealu.ModelCase

  alias Mealu.Recipe

  @valid_attrs %{name: "Name", preparation_time: 10, cooking_time: 5, serves: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
