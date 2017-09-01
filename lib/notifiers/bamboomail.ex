defmodule SlackAsap.BambooEmail do
  use Bamboo.Mailer, otp_app: :slack_asap
  import Bamboo.Email
  import SlackAsap.Message
  import SlackAsap.Utils

  @email_from get_config(SlackAsap.BambooEmail, :email_from)

  def build_body(message) do
    sender = get_parameter(message, "user_name")
    message_text = get_asap_message(message)
    "@#{sender}: <strong>#{message_text}</strong> (by Slack ASAP)"
  end

  def build(message) do
    message_text = get_asap_message(message)
    new_email(
      to: get_email(message),
      from: @email_from,
      subject: "ASAP " <> message_text,
      html_body: build_body(message),
      text_body: message_text
    )
  end

  def handle(message) do
    email = get_email(message)
    if email do
      build(message) |> deliver_later()
    end
    message
  end
end
