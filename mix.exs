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
      applications: [:bamboo, :bamboo_smtp, :cowboy, :plug, :httpoison, :ex_twilio, :ex_phone_number],
      extra_applications: [:logger],
      mod: { SlackAsap, [ start_server: Mix.env != :test ]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bamboo, "~> 0.8"},
      {:bamboo_smtp, "~> 1.4.0"},
      {:cowboy, "~> 1.0.0"},
      {:ex_phone_number, "~> 0.1"},
      {:ex_twilio, "~> 0.4.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:slack, "~> 0.12.0"}
    ]
  end
end
