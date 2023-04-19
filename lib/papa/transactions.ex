defmodule Papa.Transactions do
  alias Papa.{Repo, Transaction}

  def create_transaction(params) do
    %Transaction{}
    |> Transaction.changeset(params)
    |> Repo.insert()
  end
end
