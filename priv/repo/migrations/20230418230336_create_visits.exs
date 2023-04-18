defmodule Papa.Repo.Migrations.CreateVisits do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :member_id, references(:users)
      add :date, :utc_datetime
      add :minutes, :integer
      add :tasks, {:array, :string}, default: []

      timestamps()
    end
  end
end
