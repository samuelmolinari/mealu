defmodule Mealu.InstructionView do
  use Mealu.Web, :view

  def render("instruction.json", %{instruction: instruction}) do
    %{
      instruction: render_instruction(instruction)
    }
  end

  def render("instructions.json", %{instructions: instructions}) do
    Enum.map(instructions, &render_instruction/1)
  end

  def render_instruction(instruction) do
    %{
      id: instruction.id,
      text: instruction.text,
      position: instruction.position,
      recipe_id: instruction.recipe_id
    }
  end
end
