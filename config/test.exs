# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :slack_asap, slack_interface: SlackMock
config :slack_asap, SlackAsap.Mailer, adapter: Bamboo.TestAdapter
