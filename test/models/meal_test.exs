defmodule Mealu.MealTest do
  use Mealu.ModelCase

  alias Mealu.Meal

  @valid_attrs %{date: "2017-01-01", time: "lunch", serves: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meal.changeset(%Meal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "parse meal time" do
    assert Meal.meal_time("2017-01-01", :breakfast) == {:ok, ~N[2017-01-01 07:00:00]}
    assert Meal.meal_time("2017-01-01", :lunch) == {:ok, ~N[2017-01-01 12:00:00]}
    assert Meal.meal_time("2017-01-01", :dinner) == {:ok, ~N[2017-01-01 18:00:00]}

    assert Meal.meal_time("2017-01-01", :unknown) == {:error, :unknown_meal_time}
    assert Meal.meal_time("2017:01:01", :dinner) == {:error, :invalid_format}
    assert Meal.meal_time(nil, :dinner) == {:error, :missing_date}
  end
end
