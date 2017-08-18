defmodule SlackAsap.Mixfile do
  use Mix.Project

  def project do
    [
      app: :slack_asap,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:cowboy, :plug],
      extra_applications: [:logger],
      mod: {SlackAsap, [ start_server: Mix.env != :test ]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 3.1"}
    ]
  end
end
