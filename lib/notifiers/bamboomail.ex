defmodule SlackAsap.BambooEmail do
  use Bamboo.Mailer, otp_app: :slack_asap
  import Bamboo.Email
  import SlackAsap.Message

  def email_from() do
      result = Application.get_env(:slack_asap, SlackAsap.BambooEmail)
      |> Enum.reverse
      |> Enum.find(&match?({:email_from, _}, &1))

      elem(result || [], 1)
  end

  def build(email, message_text),
    do:
      new_email(
        to: email,
        from: email_from(),
        subject: "ASAP " <> message_text,
        html_body: "<strong>" <> message_text <> "</strong>",
        text_body: message_text
      )

  def handle(message) do
    email = get_email(message)
    if email do
      build(email, get_asap_message(message)) |> deliver_later()
    end

    message
  end
end
