defmodule SlackAsap.SlackMessage do
  use Slack
  import SlackAsap.Message

  def build_body(message) do
    sender = get_parameter(message, "user_name")
    message_text = get_asap_message(message)
    "@#{sender} sent this message to you:
> #{message_text}"
  end

  def handle(message) do
    username = get_username(message)
    if username do
      Slack.Web.Chat.post_message("@" <> username, build_body(message))
    end
    message
  end
end
