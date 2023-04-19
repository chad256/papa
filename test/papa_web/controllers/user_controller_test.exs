defmodule PapaWeb.UserControllerTest do
  use PapaWeb.ConnCase

  alias Papa.Users

  describe "create/2" do
    test "create user with valid params", %{conn: conn} do
      user_params = %{first_name: "Alice", last_name: "Jones", email: "alice@example.com"}

      response =
        conn
        |> post("/api/users", user_params)
        |> response(200)
        |> Jason.decode!()

      assert response["user"]["first_name"] == "Alice"
      assert response["user"]["last_name"] == "Jones"
      assert response["user"]["email"] == "alice@example.com"
    end

    test "create user invalid params returns error", %{conn: conn} do
      user_params = %{first_name: "Alice", last_name: "Jones", email: "invalid@example"}

      response =
        conn
        |> post("/api/users", user_params)
        |> response(500)
        |> Jason.decode!()

      assert response["error"] == "Failed to create user."
    end
  end

  describe "show/2" do
    test "returns user with corresponding id", %{conn: conn} do
      {:ok, user} =
        Users.create_user(%{first_name: "Alice", last_name: "Jones", email: "alice@example.com"})

      response =
        conn
        |> get("/api/users/#{user.id}")
        |> response(200)
        |> Jason.decode!()

      assert response["user"]["id"] == user.id
    end
  end

  test "retuns nothing for when id doesn't match a user", %{conn: conn} do
    response =
      conn
      |> get("/api/users/1")
      |> response(200)
      |> Jason.decode!()

    assert response["user"] == nil
  end

  describe "update/2" do
    test "update user with valid params", %{conn: conn} do
      {:ok, user} =
        Users.create_user(%{first_name: "Alice", last_name: "Jones", email: "alice@example.com"})

      params = %{email: "new@example.com"}

      response =
        conn
        |> put("/api/users/#{user.id}", params)
        |> response(200)
        |> Jason.decode!()

      assert response["user"]["email"] == "new@example.com"
    end

    test "update user with invalid params", %{conn: conn} do
      {:ok, user} =
        Users.create_user(%{first_name: "Alice", last_name: "Jones", email: "alice@example.com"})

      params = %{email: "invalid@example"}

      response =
        conn
        |> put("/api/users/#{user.id}", params)
        |> response(500)
        |> Jason.decode!()

      assert response["error"] == "Failed to update user."
    end
  end

  describe "delete/2" do
    test "delete existing user", %{conn: conn} do
      {:ok, user} =
        Users.create_user(%{first_name: "Alice", last_name: "Jones", email: "alice@example.com"})

      response =
        conn
        |> delete("/api/users/#{user.id}")
        |> response(200)
        |> Jason.decode!()

      assert response["message"] == "User successfully deleted."
    end

    test "delete when user doesn't exist", %{conn: conn} do
      response =
        conn
        |> delete("/api/users/1")
        |> response(500)
        |> Jason.decode!()

      assert response["error"] == "Failed to delete user."
    end
  end

  describe "index/2" do
    test "returns list of all users", %{conn: conn} do
      Users.create_user(%{first_name: "Alice", last_name: "Jones", email: "alice@example.com"})
      Users.create_user(%{first_name: "Bob", last_name: "Smith", email: "bob@example.com"})

      response =
        conn
        |> get("/api/users")
        |> response(200)
        |> Jason.decode!()

      assert length(response["users"]) == 2
    end
  end
end
