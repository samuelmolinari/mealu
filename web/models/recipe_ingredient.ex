defmodule Mealu.RecipeIngredient do
  use Mealu.Web, :model

  schema "recipes_ingredients" do
    field :quantity, :integer
    field :unit, :string
    field :notes, :string
    belongs_to :recipe, Mealu.Recipe
    belongs_to :ingredient, Mealu.Ingredient

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(quantity unit notes)a)
    |> validate_required(~w(quantity unit)a)
  end
end
