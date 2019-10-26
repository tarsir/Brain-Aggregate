use Mix.Config

# Configure your database
config :brain_aggregate, BrainAggregate.Repo,
  username: "postgres",
  password: "postgres",
  database: "brain_aggregate_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :brain_aggregate, BrainAggregateWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
