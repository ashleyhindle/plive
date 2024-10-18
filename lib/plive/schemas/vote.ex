defmodule Plive.Schemas.Vote do
  use Ecto.Schema

  import Ecto.Changeset

  schema "votes" do
    field :user_fingerprint, :string
    belongs_to :option, Plive.Schemas.Option

    timestamps()
  end

  def changeset(option, attrs) do
    option
    |> cast(attrs, [:user_fingerprint])
    |> validate_required([:user_fingerprint])
  end
end
