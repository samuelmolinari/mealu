defmodule Mealu.RecipeController do
  use Mealu.Web, :controller

  alias Mealu.Recipe

  def create(conn, params) do
    case Repo.insert(Recipe.changeset(%Recipe{}, params)) do
      {:ok, recipe} ->
        conn
        |> put_status(:created)
        |> render("recipe.json", recipe: recipe |> Repo.preload(recipes_ingredients: :ingredient) |> Repo.preload(:instructions))
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(Mealu.ErrorView, "invalid.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Recipe, id) do
      nil ->
        conn
        |> put_status(404)
        |> render(Mealu.ErrorView, "404.json")
      recipe -> render(conn, "recipe.json", recipe: recipe |> Repo.preload(recipes_ingredients: :ingredient) |> Repo.preload(:instructions))
    end
  end
end
