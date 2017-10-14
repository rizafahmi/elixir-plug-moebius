use Mix.Config

config :helloplug, Helloplug.Repo,
  adapter: Sqlite.Ecto,
  database: "hello_plug.sqlite3"
