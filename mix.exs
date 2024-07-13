defmodule AtomicRepro.MixProject do
  use Mix.Project

  def project do
    [
      app: :atomic_repro,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :dev,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {AtomicRepro.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:picosat_elixir, "~> 0.2"},
      # {:ash, "~> 3.0"},
      {:ash, github: "ash-project/ash", branch: "main", override: true},
      {:ash_postgres, github: "ash-project/ash_postgres", branch: "main", override: true},
      # {:ash_postgres, "~> 2.0"},
      {:ash_sql, github: "ash-project/ash_sql", branch: "main", override: true},
      {:ash_state_machine, "~> 0.0"},
      {:igniter, "~> 0.2"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp elixirc_paths(:test), do: elixirc_paths(:dev) ++ ["test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
