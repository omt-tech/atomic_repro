defmodule AtomicRepro.Repo do
  use AshPostgres.Repo, otp_app: :atomic_repro

  # Installs Postgres extensions that ash commonly uses
  def installed_extensions do
    ["uuid-ossp", "citext", "ash-functions"]
  end
end
