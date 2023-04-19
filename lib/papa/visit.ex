defmodule Papa.Visit do
  use Ecto.Schema
  import Ecto.Changeset

  alias Papa.User

  @derive {Jason.Encoder, only: [:id, :date, :minutes, :tasks, :member_id]}

  schema "visits" do
    field :date, :utc_datetime
    field :minutes, :integer
    field :tasks, {:array, :string}

    belongs_to :member, User

    timestamps()
  end

  def changeset(visit, attrs) do
    visit
    |> cast(attrs, [:date, :minutes, :tasks, :member_id])
    |> validate_required([:date, :minutes, :member_id])
    |> foreign_key_constraint(:member_id)
  end
end
