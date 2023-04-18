defmodule PapaWeb.UserControllerTest do
  use PapaWeb.ConnCase

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
end
