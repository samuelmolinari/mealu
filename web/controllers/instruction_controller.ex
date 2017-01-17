defmodule Mealu.InstructionController do
  use Mealu.Web, :controller

  alias Mealu.Recipe
  alias Mealu.Instruction

  def create(conn, params = %{"recipe_id" => recipe_id}) do
    recipe = recipe(recipe_id)

    changeset = Instruction.changeset(%Instruction{recipe: recipe}, Map.put(params, "position", next_instruction_position(recipe_id)))

    case Repo.insert(changeset) do
      {:ok, instruction} -> render(conn, "instruction.json", instruction: instruction)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(Mealu.ErrorView, "invalid.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "recipe_id" => recipe_id, "text" => text}) do
    changeset = Repo.get_by(Instruction, id: id, recipe_id: recipe_id)
                |> Instruction.changeset(%{"text" => text})

    case Repo.update(changeset) do
      {:ok, instruction} -> render(conn, "instruction.json", instruction: instruction)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(Mealu.ErrorView, "invalid.json", changeset: changeset)
    end
  end

  def reorder(conn, %{"recipe_id" => recipe_id, "ids" => ids}) do
    instructions = Repo.all(from(i in Instruction, where: i.recipe_id == ^recipe_id and i.id in ^ids))
                   |> Enum.map(fn(instruction) ->
                     Repo.update(Instruction.changeset(instruction, %{"position" => Enum.find_index(ids, fn(id) -> instruction.id == id end) + 1}))
                   end)
                   |> Enum.map(fn({:ok, instruction}) -> instruction end)

    render(conn, "instructions.json", instructions: instructions)
  end

  defp recipe(id) do
    Repo.get(Recipe, id)
  end

  defp next_instruction_position(recipe_id) do
    Repo.aggregate(from(i in Instruction, where: i.recipe_id == ^recipe_id), :count, :id) + 1
  end
end
