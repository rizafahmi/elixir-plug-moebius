use Mix.Config

config :moebius,
  connection: [
    hostname: "localhost",
    username: "postgres",
    database: "helloplug_dev",
    pool_mod: DBConnection.Poolboy
  ],
  scripts: "test/db"
