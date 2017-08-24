# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :slack_asap, token: "K8HPzzr1WNX1i9teVoePOVIQ",
                    port: 4000,
                    notifiers: [
                      SlackAsap.TwilioSMS,
                      SlackAsap.SlackMessage,
                      SlackAsap.BambooEmail
                    ],
                    slack_interface: Slack

config :slack_asap, SlackAsap.BambooEmail,
                    %{email_from: "slack_asap@sophilabs.com"}

config :slack_asap, SlackAsap.Mailer,
                      adapter: Bamboo.MailgunAdapter,
                      api_key: "key-3ece3fafa847a969198450ba1c7fe494",
                      domain: "sandbox4d556973c28c4113937824f0a9826659.mailgun.org"

config :ex_twilio, account_sid: {:system, "AC5584aa7573024a2e62a4e9046d78ed04"},
                   auth_token: {:system, "497f1399531c5edaea91ffc84484d86b"}


config :slack, api_token: "xoxb-232142658614-IIickPjzq6LsogvmI4I62KXn"

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#

import_config "#{Mix.env}.exs"
