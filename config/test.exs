import Config

config :plive, Plive.Repo,
  database: Path.expand("../plive_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :plive, PliveWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "FW/SnMre1I+ykko6LAwFqfdisO2WCWbFljv5/dIcfz2o/hJm5EmG3xD89KscSzXw",
  server: false

# In test we don't send emails.
config :plive, Plive.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true
