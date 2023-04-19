defmodule Papa.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Papa.{User, Visit}

  @derive {Jason.Encoder, only: [:id, :member_id, :pal_id, :visit_id]}

  schema "transactions" do
    belongs_to :member, User
    belongs_to :pal, User
    belongs_to :visit, Visit

    timestamps()
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:member_id, :pal_id, :visit_id])
    |> validate_required([:member_id, :pal_id, :visit_id])
    |> foreign_key_constraint(:member_id)
    |> foreign_key_constraint(:pal_id)
    |> foreign_key_constraint(:visit_id)
  end
end
