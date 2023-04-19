defmodule PapaWeb.VisitControllerTest do
  use PapaWeb.ConnCase

  alias Papa.{Users, Transactions, Visits}

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

  describe "index/2" do
    setup do
      {:ok, user1} =
        Users.create_user(%{first_name: "Alice", last_name: "Jones", email: "alice@example.com"})

      {:ok, user2} =
        Users.create_user(%{first_name: "Bob", last_name: "Smith", email: "bob@example.com"})

      {:ok, visit1} =
        Visits.create_visit(%{
          member_id: user1.id,
          date: DateTime.utc_now(),
          minutes: 50,
          tasks: ["clean"]
        })

      {:ok, visit2} =
        Visits.create_visit(%{
          member_id: user1.id,
          date: DateTime.utc_now(),
          minutes: 30,
          tasks: ["play chess"]
        })

      Transactions.create_transaction(%{
        member_id: user1.id,
        pal_id: user2.id,
        visit_id: visit1.id
      })

      %{fulfilled_visit: visit1, unfulfilled_visit: visit2}
    end

    test "returns all visits", %{conn: conn} do
      response =
        conn
        |> get("/api/visits")
        |> response(200)
        |> Jason.decode!()

      assert length(response["visits"]) == 2
    end

    test "returns all unfulfilled visits", %{conn: conn, unfulfilled_visit: unfulfilled_visit} do
      response =
        conn
        |> get("/api/visits", opts: :unfulfilled_visits)
        |> response(200)
        |> Jason.decode!()

      assert length(response["visits"]) == 1
      assert hd(response["visits"])["id"] == unfulfilled_visit.id
    end

    test "returns all fulfilled visits", %{conn: conn, fulfilled_visit: fulfilled_visit} do
      response =
        conn
        |> get("/api/visits", opts: :fulfilled_visits)
        |> response(200)
        |> Jason.decode!()

      assert length(response["visits"]) == 1
      assert hd(response["visits"])["id"] == fulfilled_visit.id
    end
  end
end
