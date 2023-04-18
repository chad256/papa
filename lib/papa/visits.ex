defmodule Papa.Visits do
  alias Papa.{Repo, Visit}

  def create_visit(params) do
    %Visit{}
    |> Visit.changeset(params)
    |> Repo.insert()
  end
end
