use Mix.Config

# Configure your database
config :radio_system, RadioSystem.Repo,
  username: "postgres",
  password: "postgres",
  database: "radio_system_test",
  hostname: System.get_env("POSTGRES_HOST"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :radio_system, RadioSystemWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
