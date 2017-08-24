# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :slack_asap, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:slack_asap, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :slack_asap, token: "K8HPzzr1WNX1i9teVoePOVIQ",
                    port: 4000,
                    notifiers: [
                      SlackAsap.TwilioSMS,
                      SlackAsap.SlackMessage,
                      SlackAsap.BambooEmail
                    ]

config :ex_twilio, account_sid: {:system, "AC5584aa7573024a2e62a4e9046d78ed04"},
                   auth_token: {:system, "497f1399531c5edaea91ffc84484d86b"}


#config :slack, api_token: "xoxp-2360007319-174436881879-227933436512-e25994edfeee823187a332e6f2ac265c"
config :slack, api_token: "xoxb-232142658614-IIickPjzq6LsogvmI4I62KXn"
