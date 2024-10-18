defmodule Plive.Repo.Migrations.CreatePollsTable do
  use Ecto.Migration

  def change do
    create table(:polls) do
      add :question, :string
      timestamps()
    end
  end
end
