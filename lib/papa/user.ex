defmodule Papa.User do
  use Ecto.Schema
  import Ecto.Changeset

  @email_regex ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

  @derive {Jason.Encoder, only: [:first_name, :last_name, :email]}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string

    timestamps()
  end

  def changeset(changeset, attrs) do
    changeset
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_format(:email, @email_regex)
  end
end
