defmodule Papa.Transactions do
  alias Papa.{Repo, Transaction, Users, Visits}

  def create_transaction(params) do
    %Transaction{}
    |> Transaction.changeset(params)
    |> Repo.insert()
    |> update_user_minutes()
  end

  def update_user_minutes({:error, error}), do: {:error, error}

  def update_user_minutes(
        {:ok, %{pal_id: pal_id, member_id: member_id, visit_id: visit_id} = transaction}
      ) do
    visit = Visits.get_visit(visit_id)

    pal_minutes = round(visit.minutes - visit.minutes * 0.15)
    Users.update_minutes(pal_id, pal_minutes)

    Users.update_minutes(member_id, -visit.minutes)
    {:ok, transaction}
  end
end
