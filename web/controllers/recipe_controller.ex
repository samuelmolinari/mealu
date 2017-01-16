defmodule Mealu.RecipeController do
  use Mealu.Web, :controller

  alias Mealu.Recipe

  def create(conn, params) do
    case Repo.insert(Recipe.changeset(%Recipe{}, params)) do
      {:ok, recipe} ->
        conn
        |> put_status(:created)
        |> render("recipe.json", recipe: recipe |> Repo.preload(recipes_ingredients: :ingredient))
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(Mealu.ErrorView, "invalid.json", changeset: changeset)
    end
  end
end
