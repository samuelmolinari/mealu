defmodule Mealu.Meal do
  use Mealu.Web, :model

  schema "meals" do
    field :serves, :integer
    field :due_at, Ecto.DateTime
    belongs_to :recipe, Mealu.Recipe

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:serves, :due_at])
    |> validate_required([:serves, :due_at])
    |> cast_assoc(:recipe)
  end
end
