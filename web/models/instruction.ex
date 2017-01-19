defmodule Mealu.Instruction do
  use Mealu.Web, :model

  schema "instructions" do
    field :text, :string
    field :position, :integer, default: 0
    belongs_to :recipe, Mealu.Recipe

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :position])
    |> validate_required([:position])
  end
end
