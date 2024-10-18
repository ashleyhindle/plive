defmodule Plive.Repo.Migrations.CreateOptionsTable do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :text, :string
      add :poll_id, references(:polls)

      timestamps()
    end
  end
end
