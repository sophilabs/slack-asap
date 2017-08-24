defmodule SlackAsap.BambooEmail do
  import Bamboo.Email
  import SlackAsap.Message

  @email_from Application.get_env(:slack_asap, SlackAsap.BambooEmail).email_from

  def build(email, message_text),
    do:
      new_email(
        to: email,
        from: @email_from,
        subject: "ASAP " <> message_text,
        html_body: "<strong>" <> message_text <> "</strong>",
        text_body: message_text
      )

  def handle(message) do
    email = get_email(message)
    if email do
      build(email, get_asap_message(message)) |> SlackAsap.Mailer.deliver_later
    end

    message
  end
end
