defmodule Papa.Seeds do
  alias Papa.{Users, Visits, Transactions}

  def run do
    {:ok, user1} =
      Users.create_user(%{
        "first_name" => "Phil",
        "last_name" => "Jones",
        "email" => "phil@example.com",
        "minutes" => 50
      })

    {:ok, user2} =
      Users.create_user(%{
        "first_name" => "Jane",
        "last_name" => "Rogers",
        "email" => "jane@example.com",
        "minutes" => 120
      })

    {:ok, user3} =
      Users.create_user(%{
        "first_name" => "Mary",
        "last_name" => "Smith",
        "email" => "mary@example.com",
        "minutes" => 200
      })

    {:ok, visit1} =
      Visits.create_visit(%{
        "date" => DateTime.utc_now(),
        "minutes" => 30,
        "tasks" => ["clean"],
        "member_id" => user1.id
      })

    {:ok, visit2} =
      Visits.create_visit(%{
        "date" => DateTime.utc_now(),
        "minutes" => 50,
        "tasks" => ["talk"],
        "member_id" => user2.id
      })

    {:ok, transaction} =
      Transactions.create_transaction(%{
        "member_id" => user1.id,
        "pal_id" => user3.id,
        "visit_id" => visit1.id
      })
  end
end

Papa.Seeds.run()
