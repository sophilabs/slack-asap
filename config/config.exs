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

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#

import_config "#{Mix.env}.exs"
