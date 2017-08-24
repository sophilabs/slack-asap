defmodule SlackAsap.Core do
  import SlackAsap.Message

  @slack_interface Application.get_env(:slack_asap, :slack_interface)

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
    if is_ok?(message) do
      if get_username(message) != nil do
        message |> put_text(@ack_message)
      else
        message |> put_text(@usage_message)
      end
    else
      message
    end
  end

  defp get_profile(username),
    do: @slack_interface.Web.Users.list()["members"]
      |> Enum.find(fn(user) -> user["name"] == username end)

  def put_profile_info(message) do
    if is_ok?(message) do
      profile_info = message |> get_username() |> get_profile()
      %{message | profile: (profile_info || %{})}
    else
      message
    end
  end

  def handle(message) do
    message
      |> verify_token()
      |> put_type(:ephemeral)
      |> put_profile_info()
      |> put_ack_text()
  end
end
