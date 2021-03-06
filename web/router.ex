defmodule Mealu.Router do
  use Mealu.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Mealu do
    pipe_through :api

    resources "/recipes", RecipeController, only: [:create, :show] do
      resources "/ingredients", IngredientController, only: [:create, :delete]
      resources "/meals", MealController, only: [:create]

      patch "/instructions/reorder", InstructionController, :reorder
      resources "/instructions", InstructionController, only: [:create, :update]
    end
  end
end
