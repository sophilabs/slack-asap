# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Slack
config :slack, api_token: System.get_env("SLACK_API_KEY")

config :slack_asap, token: System.get_env("SLACK_VERIFICATION_TOKEN")

# Twilio
config :slack_asap, SlackAsap.TwilioSMS,
    phone_number: System.get_env("TWILIO_PHONE_NUMBER"),
    default_country: "UY"

config :ex_twilio, account_sid: System.get_env("TWILIO_ACCOUNT_ID"),
                   auth_token: System.get_env("TWILIO_ACCOUNT_TOKEN")

# Bamboo
config :slack_asap, SlackAsap.BambooEmail,
      adapter: Bamboo.SMTPAdapter,
      server: System.get_env("EMAIL_HOST"),
      port: System.get_env("EMAIL_PORT"),
      username: System.get_env("EMAIL_HOST_USER"),
      password: System.get_env("EMAIL_HOST_PASSWORD"),
      tls: :always,
      allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"],
      ssl: false,
      retries: 2
