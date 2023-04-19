defmodule Papa.Users do
  import Ecto.Query

  alias Papa.{Repo, User, Users}

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_users do
    Repo.all(User)
  end

  def update_user(id, params) do
    with user = %User{} <- Users.get_user(id),
         {:ok, updated_user} <- User.changeset(user, params) |> Repo.update() do
      {:ok, updated_user}
    else
      _ ->
        {:error, "Failed to update user."}
    end
  end

  def delete_user(id) do
    with user = %User{} <- Users.get_user(id) do
      Repo.delete(user)
    else
      _ ->
        {:error, "Failed to delete user."}
    end
  end

  def update_minutes(user_id, minutes) do
    User
    |> where([u], u.id == ^user_id)
    |> update([u], set: [minutes: u.minutes + ^minutes])
    |> Repo.update_all([])
  end
end
