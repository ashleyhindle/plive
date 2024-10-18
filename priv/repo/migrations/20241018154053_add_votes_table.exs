defmodule Plive.Repo.Migrations.AddVotesTable do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :option_id, references(:options)
      add :user_fingerprint, :string
      timestamps()
    end
  end
end
