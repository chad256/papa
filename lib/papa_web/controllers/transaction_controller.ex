defmodule PapaWeb.TransactionController do
  use PapaWeb, :controller

  alias Papa.Transactions

  def create(conn, params) do
    case Transactions.create_transaction(params) do
      {:ok, transaction} ->
        json(conn, %{transaction: transaction})

      {:error, _} ->
        conn
        |> put_status(500)
        |> json(%{error: "Failed to create transaction."})
    end
  end
end
