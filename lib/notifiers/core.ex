defmodule SlackAsap.Core do
  import SlackAsap.Message

  def verify_token(message) do
    if get_parameter(message, "token") == Application.get_env(:slack_asap, :token) do
      message
    else
      message |> put_text("token validation failed") |> fail()
    end
  end

  def handle(message) do
    message
      |> put_type("ephemeral")
      |> put_text("We are sending the reminders. We will try to be as annoying as possible.")
      |> verify_token()
  end
end
