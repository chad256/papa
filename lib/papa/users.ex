defmodule Papa.Users do
  alias Papa.{Repo, User}

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end
end
