defmodule Worbee.Repo do
  use Ecto.Repo,
    otp_app: :worbee,
    adapter: Ecto.Adapters.Postgres
end
