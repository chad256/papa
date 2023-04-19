defmodule Papa.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :member_id, references(:users)
      add :pal_id, references(:users)
      add :visit_id, references(:visits)

      timestamps()
    end
  end
end
