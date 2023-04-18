defmodule PapaWeb.UserController do
  use PapaWeb, :controller

  alias Papa.Users

  def create(conn, params) do
    case Users.create_user(params) do
      {:ok, user} ->
        json(conn, %{user: user})

      {:error, _} ->
        conn
        |> put_status(500)
        |> json(%{error: "Failed to create user."})
    end
  end
end
