defmodule Plive.Schemas.Poll do
  use Ecto.Schema

  import Ecto.Changeset

  schema "polls" do
    field :question, :string
    field :slug, :string
    has_many :options, Plive.Schemas.Option, on_replace: :delete
    timestamps()
  end

  def changeset(poll, attrs) do
    poll
    |> cast(attrs, [:question, :slug])
    |> cast_assoc(:options, required: true)
    |> validate_required([:question, :slug])
    |> validate_length(:question, min: 1)
    |> validate_length(:slug, min: 1)
  end
end
