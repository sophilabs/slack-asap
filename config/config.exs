# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :slack_asap, token: "<put-value-here>",
                    port: 4000,
                    notifiers: [
                      SlackAsap.TwilioSMS,
                      SlackAsap.SlackMessage,
                      SlackAsap.BambooEmail
                    ],
                    slack_interface: Slack

config :slack_asap, SlackAsap.BambooEmail,
                      adapter: Bamboo.LocalAdapter,
                      email_from: "some@email.com"

config :slack_asap, SlackAsap.TwilioSMS,
                      adapter: ExTwilio

import_config "#{Mix.env}.exs"
