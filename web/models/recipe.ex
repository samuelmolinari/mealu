defmodule Mealu.Recipe do
  use Mealu.Web, :model

  schema "recipes" do
    field :name, :string
    field :preparation_time, :integer
    field :cooking_time, :integer
    field :serves, :integer

    has_many :recipes_ingredients, Mealu.RecipeIngredient
    has_many :instructions, Mealu.Instruction

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(name preparation_time cooking_time serves)a)
    |> validate_required(~w(name preparation_time cooking_time serves)a)
  end
end
