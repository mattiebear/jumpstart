defmodule Jumpstart.Repo do
  use Ecto.Repo,
    otp_app: :jumpstart,
    adapter: Ecto.Adapters.Postgres
end
