defmodule Plive do
  alias Plive.Schemas.Poll

  def create_poll(attrs) do
    %Poll{}
    |> Poll.changeset(attrs)
    |> Plive.Repo.insert()
  end

  def update_poll(%Poll{} = poll, attrs) do
    poll
    |> Poll.changeset(attrs)
    |> Plive.Repo.update()
  end
end
