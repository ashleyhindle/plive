defmodule Plive.Schemas.Option do
  use Ecto.Schema

  import Ecto.Changeset

  schema "options" do
    field :text, :string
    has_many :votes, Plive.Schemas.Vote
    belongs_to :poll, Plive.Schemas.Poll

    timestamps()
  end

  def changeset(option, attrs) do
    option
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
