defmodule PapaWeb.Router do
  use PapaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PapaWeb do
    pipe_through :api

    resources "/users", UserController, except: [:index, :new, :edit]
  end
end
