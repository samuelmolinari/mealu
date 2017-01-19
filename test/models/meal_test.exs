defmodule Mealu.MealTest do
  use Mealu.ModelCase

  alias Mealu.Meal

  @valid_attrs %{due_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, serves: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meal.changeset(%Meal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
