defmodule PapaWeb.Router do
  use PapaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PapaWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/visits", VisitController, only: [:create, :index, :update]
    resources "/transactions", TransactionController, only: [:create, :index]
  end
end
