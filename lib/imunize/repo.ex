defmodule Imunize.Repo do
  use Ecto.Repo,
    otp_app: :imunize,
    adapter: Ecto.Adapters.Postgres
end
