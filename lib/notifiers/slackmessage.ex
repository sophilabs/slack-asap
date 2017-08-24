defmodule SlackAsap.SlackMessage do
  use Slack
  import SlackAsap.Message

  def handle(message) do
    username = get_username(message)
    if username do
      asap_message = get_asap_message(message)
      Slack.Web.Chat.post_message("@" <> username, asap_message, %{})
    end
    message
  end
end
