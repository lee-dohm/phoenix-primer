defmodule Primer.MixProject do
  use Mix.Project

  def project do
    [
      app: :primer,
      version: "0.1.0",
      elixir: "~> 1.6",
      name: "Phoenix Primer",
      description: "Utilities for making generating a Primer CSS Phoenix website simpler",
      source_url: "https://github.com/lee-dohm/phoenix-primer",
      homepage_url: "https://github.com/lee-dohm/phoenix-primer",
      deps: deps(),
      docs: docs(),
      package: package(),
      test_coverage: [tool: ExCoveralls, test_task: "test"],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.travis": :test,
        credo: :test,
        docs: :test
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_html, "~> 2.11"},
      {:cmark, "~> 0.7", only: [:test], runtime: false},
      {:credo, "~> 0.9.2", only: [:test], runtime: false},
      {:ex_doc, "~> 0.16", only: [:test], runtime: false},
      {:excoveralls, "~> 0.6", only: :test},
      {:floki, "~> 0.20", only: [:dev, :test]},
      {:version_tasks, "~> 0.10", only: :dev}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "CODE_OF_CONDUCT.md",
        "README.md": [
          filename: "readme",
          title: "README"
        ],
        "LICENSE.md": [
          filename: "license",
          title: "License"
        ]
      ]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Lee Dohm"],
      links: %{"GitHub" => "https://github.com/lee-dohm/phoenix-primer"}
    ]
  end
end
