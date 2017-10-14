defmodule Helloplug.Repo do
  use Ecto.Repo,
    otp_app: :helloplug,
    adapter: Sqlite.Ecto
end
