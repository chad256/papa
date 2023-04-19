defmodule PapaWeb.TransactionControllerTest do
  use PapaWeb.ConnCase

  alias Papa.{Transactions, Users, Visits}

  setup do
    {:ok, member} =
      %{first_name: "Alice", last_name: "Jones", email: "alice@example.com", minutes: 200}
      |> Users.create_user()

    {:ok, pal} =
      %{first_name: "Bob", last_name: "Smith", email: "bob@example.com", minutes: 0}
      |> Users.create_user()

    %{member: member, pal: pal}
  end

  describe "create/2" do
    test "creates transaction with valid params and transfer minutes to pal", %{
      conn: conn,
      member: member,
      pal: pal
    } do
      {:ok, visit} =
        Visits.create_visit(%{
          "member_id" => member.id,
          "date" => DateTime.utc_now(),
          "minutes" => 100,
          "tasks" => ["clean", "talk"]
        })

      response =
        conn
        |> post("/api/transactions", %{member_id: member.id, pal_id: pal.id, visit_id: visit.id})
        |> response(200)
        |> Jason.decode!()

      assert response["transaction"]["pal_id"] == pal.id
      assert response["transaction"]["member_id"] == member.id
      assert response["transaction"]["visit_id"] == visit.id

      member = Users.get_user(member.id)
      pal = Users.get_user(pal.id)

      assert member.minutes == 100
      assert pal.minutes == 85
    end

    test "create transaction with invalid params", %{conn: conn, member: member, pal: pal} do
      response =
        conn
        |> post("/api/transactions", %{member_id: member.id, pal_id: pal.id})
        |> response(500)
        |> Jason.decode!()

      assert response["error"] == "Failed to create transaction."
    end
  end

  describe "index/2" do
    test "returns list of all transactions", %{conn: conn, member: member, pal: pal} do
      {:ok, visit} =
        Visits.create_visit(%{
          "member_id" => member.id,
          "date" => DateTime.utc_now(),
          "minutes" => 100,
          "tasks" => ["clean", "talk"]
        })

      Transactions.create_transaction(%{
        "member_id" => member.id,
        "pal_id" => pal.id,
        "visit_id" => visit.id
      })

      response =
        conn
        |> get("/api/transactions")
        |> response(200)
        |> Jason.decode!()

      assert length(response["transactions"]) == 1
    end
  end
end
