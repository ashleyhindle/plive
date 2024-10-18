defmodule Plive.Repo.Migrations.AddSlugToPollsTable do
  use Ecto.Migration

  def change do
    alter table(:polls) do
      add :slug, :string
    end

    create unique_index(:polls, [:slug])
  end
end
