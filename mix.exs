defmodule Munition.MixProject do
  use Mix.Project

  def project do
    [
      app: :munition,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),

      # Docs
      name: "Munition",
      source_url: "https://github.com/hyperpolymath/chimichanga",
      docs: [
        main: "Munition",
        extras: ["README.md", "ARCHITECTURE.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto],
      mod: {Munition.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # WASM runtime
      {:wasmex, "~> 0.9"},

      # JSON encoding for benchmarks and dumps
      {:jason, "~> 1.4"},

      # Development and testing
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},

      # Benchmarking
      {:benchee, "~> 1.3", only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      test: ["test"],
      "test.integration": ["test --only integration"],
      bench: ["run bench/startup_bench.exs"]
    ]
  end
end
