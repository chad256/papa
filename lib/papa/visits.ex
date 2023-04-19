defmodule Papa.Visits do
  import Ecto.Query

  alias Papa.{Repo, Transaction, Visit}

  def create_visit(params) do
    %Visit{}
    |> Visit.changeset(params)
    |> Repo.insert()
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
end
