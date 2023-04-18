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

  def show(conn, %{"id" => id}) do
    user = Users.get_user(id)
    json(conn, %{user: user})
  end

  def update(conn, %{"id" => id} = params) do
    case Users.update_user(id, params) do
      {:ok, user} ->
        json(conn, %{user: user})

      {:error, error} ->
        conn
        |> put_status(500)
        |> json(%{error: error})
    end
  end
end
