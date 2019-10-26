defmodule BrainAggregate.Repo do
  use Ecto.Repo,
    otp_app: :brain_aggregate,
    adapter: Ecto.Adapters.Postgres
end
