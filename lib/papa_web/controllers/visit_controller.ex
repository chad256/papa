defmodule PapaWeb.VisitController do
  use PapaWeb, :controller

  alias Papa.Visits

  def create(conn, params) do
    case Visits.create_visit(params) do
      {:ok, visit} ->
        json(conn, %{visit: visit})

      {:error, _} ->
        conn
        |> put_status(500)
        |> json(%{error: "Failed to create visit."})
    end
  end
end
