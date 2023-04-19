# Papa Exercise

To get started:

* Run `mix setup` to install dependencies and setup databse with seed data.
* Use `mix test` to run all tests.
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`.

The application is a json api accessible at `localhost:4000`.

Users can be created at `/api/users` with fields `first_name`, `last_name`, `email`, and `minutes`.

Users can request visits by creating a new visit at `/api/visits` with fields `member_id`, `date`, `minutes`, and `tasks`, where example tasks are [`"mow lawn", "play chess"]`. If the user has less minutes in their profile than the minutes they are requesting in the visit, then their visit will not be created.

A user can fulfill a visit by creating a new transaction at `/api/transactions`, with fields `member_id`, `pal_id`, and `visit_id`. The `member_id` corresponds to the user who requested the visit, and the `pal_id` refers to the user who fulfilled the visit. The pal will be credited the minutes from the visit to their profile, minus a 15% deduction, and the member will be deducted all of the minutes of the visit from their profile.

Lists of all unfulfilled or fulfilled visits can be accessed at `api/visits` with parameters `{"opts": "unfullfilled"}` or `{"opts": "fulfilled"}`.

List of available endpoints:

  * GET      /api/users/:id
  * POST    /api/users
  * PATCH   /api/users/:id
  * PUT     /api/users/:id
  * DELETE  /api/users/:id
  * GET     /api/visits
  * POST    /api/visits
  * PATCH   /api/visits/:id
  * PUT     /api/visits/:id
  * POST    /api/transactions
