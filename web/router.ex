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

     resources "/recipes", RecipeController, only: [:create]
   end
end
