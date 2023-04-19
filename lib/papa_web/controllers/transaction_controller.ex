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

  def index(conn, _) do
    transactions = Transactions.get_transactions()
    json(conn, %{transactions: transactions})
  end
end
