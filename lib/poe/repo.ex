defmodule Poe.Repo do
  use Ecto.Repo,
    otp_app: :poe,
    adapter: Ecto.Adapters.SQLite3
end
