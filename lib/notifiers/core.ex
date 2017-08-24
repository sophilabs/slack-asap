defmodule SlackAsap.Core do
  import SlackAsap.Message

  @ack_message "We are sending the reminders. We will try to be as annoying as possible."
  @usage_message "/asap username message"

  def verify_token(message) do
    if get_parameter(message, "token") == Application.get_env(:slack_asap, :token) do
      message
    else
      message |> put_text("token validation failed") |> fail()
    end
  end

  def put_ack_text(message) do
    if get_username(message) != nil do
      message |> put_text(@ack_message)
    else
      message |> put_text(@usage_message)
    end
  end

  def handle(message) do
    message
      |> put_type(:ephemeral)
      |> put_ack_text()
      |> verify_token()
  end
end
