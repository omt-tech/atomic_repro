import Config

config :atomic_repro, AtomicRepro.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "atomic_repro_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
