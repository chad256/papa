defmodule Papa.Repo.Migrations.AddMinutesToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :minutes, :integer
    end
  end
end
