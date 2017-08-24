# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :slack_asap,
  slack_interface: SlackMock,
  token: "Some-token"

config :slack_asap, SlackAsap.BambooEmail, adapter: Bamboo.TestAdapter,
    email_from: "foo@bar.com"
