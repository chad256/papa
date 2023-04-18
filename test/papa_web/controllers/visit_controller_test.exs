defmodule PapaWeb.VisitControllerTest do
  use PapaWeb.ConnCase

  alias Papa.Users

  describe "create/2" do
    setup do
      {:ok, user} =
        %{first_name: "Alice", last_name: "Jones", email: "alice@example.com"}
        |> Users.create_user()

      %{user: user}
    end

    test "create visit with valid params", %{conn: conn, user: user} do
      visit_params = %{
        member_id: user.id,
        date: DateTime.utc_now(),
        minutes: 30,
        tasks: ["fix appliance", "play chess"]
      }

      response =
        conn
        |> post("/api/visits", visit_params)
        |> response(200)
        |> Jason.decode!()

      assert response["visit"]["member_id"] == user.id
    end

    test "create visit with invalid params", %{conn: conn} do
      visit_params = %{
        member_id: 99999,
        date: DateTime.utc_now(),
        minutes: 30,
        tasks: ["fix appliance", "play chess"]
      }

      response =
        conn
        |> post("/api/visits", visit_params)
        |> response(500)
        |> Jason.decode!()

      assert response["error"] == "Failed to create visit."
    end
  end
end
