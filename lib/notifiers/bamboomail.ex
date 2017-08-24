defmodule SlackAsap.BambooEmail do
  import Bamboo.Email
  import SlackAsap.Message

  @slack_interface Application.get_env(:slack_asap, :slack_interface)
  @email_from Application.get_env(:slack_asap, SlackAsap.BambooEmail).email_from

  defp get_profile(username),
    do: @slack_interface.Web.Users.list()["members"]
      |> Enum.find(fn(user) -> user["name"] == username end)

  defp get_email_from_user_dict(%{ "profile" => profile } = _userObject),
    do: profile["email"]

  defp get_email_from_user_dict(_any),
    do: nil

  def get_email(username),
    do: username |> get_profile() |> get_email_from_user_dict()

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
    username = get_username(message)
    asap_message = get_asap_message(message)
    email = get_email(username)

    if email do
      build(email, asap_message) |> SlackAsap.Mailer.deliver_later
    end

    message
  end
end
