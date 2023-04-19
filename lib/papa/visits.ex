defmodule Papa.Visits do
  import Ecto.Query

  alias Papa.{Repo, Transaction, User, Users, Visit}

  def create_visit(params) do
    with member_id when is_integer(member_id) <- params["member_id"],
         member = %User{} <- Users.get_user(member_id),
         true <- member.minutes >= params["minutes"] do
      %Visit{}
      |> Visit.changeset(params)
      |> Repo.insert()
    else
      _ ->
        {:error, "Failed to create visit"}
    end
  end

  def get_visits("unfulfilled_visits") do
    Visit
    |> join(:inner, [v], t in Transaction, on: v.id != t.visit_id)
    |> select([v, t], v)
    |> Repo.all()
  end

  def get_visits("fulfilled_visits") do
    Visit
    |> join(:inner, [v], t in Transaction, on: v.id == t.visit_id)
    |> select([v, t], v)
    |> Repo.all()
  end

  def get_visits(_) do
    Repo.all(Visit)
  end

  def get_visit(visit_id) do
    Repo.get(Visit, visit_id)
  end
end
