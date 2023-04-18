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
end
