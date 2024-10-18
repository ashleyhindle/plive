defmodule Plive.Repo do
  use Ecto.Repo,
    otp_app: :plive,
    adapter: Ecto.Adapters.SQLite3
end
