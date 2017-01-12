defmodule Mealu.Factory do
  use ExMachina.Ecto, repo: Mealu.Repo

  def recipe_factory do
    %Mealu.Recipe{
      name: "Factory recipe",
      preparation_time: 60,
      cooking_time: 120,
      serves: 2
    }
  end
end
