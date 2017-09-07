defmodule SlackAsap.Core do
  import SlackAsap.Message

  @slack_interface Application.get_env(:slack_asap, :slack_interface)

  @ack_message "We are sending the reminders. We will try to be as annoying as possible."
  @usage_message ":wave: Need some help with `/asap`?

Use `/asap` to message a user about an urgent message:
`/asap @luis The food arrived`
`/asap @jessica Someone is looking for you`
`/asap @peter Nobody likes U`"

  @usage_attachment "If you liked the command, check out the code in https://github.com/sophilabs/slack_asap"

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
                |> add_text_attachment(@usage_attachment)
      end
    else
      message
    end
  end

  defp validate_list(%{ "error" => errorReason } = response) do
    IO.puts(:stderr, "Warning: Error when calling Slack List: #{errorReason}")
    response
  end

  defp validate_list(response), do:
    response

  defp get_profile(username),
    do: @slack_interface.Web.Users.list()
      |> validate_list()
      |> Map.get("members", [])
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
