defmodule SlackAsap.Message do
  defstruct [
      status: :ok,
      text: "",
      response_type: "in_channel",
      parameters: %{},
      profile: %{}
  ]

  # A message @<user> <message>
  @regular_regex ~r/^\s*@?(?<user>\w+)\s+(?<message>.*)$/

  # Expression for help messages
  @help_regex ~r/^\s*(help|usage|)\s*$/i

  @doc """
    Assigns a new response to the command. This will be shown to the user
    When the command returns
  """
  def put_text(message, text),
    do: %{message | text: text}

  @doc """
    Assigns a new response type to the command. Response_type can be
    :in_channel: Visible to all users
    :ephemeral: Visiable to only the user
  """
  def put_type(message, response_type) do
    case response_type do
      :in_channel ->
        %{message | response_type: "in_channel"}
      :ephemeral ->
          %{message | response_type: "ephemeral"}
      _ ->
        raise("Invalid response type.")
    end
  end

  @doc """
    Returns True if the message is correct and can be processed by notifiers.
    Can be set as invalid fail/1 to indicate is in a bad state.
  """
  def is_ok?(%{ :status => :ok }),
    do: true

  def is_ok?(_message),
    do: false

  @doc """
    Get original slack raw message parameters. Known message keys and example values
    are

    %{
      "channel_id" => "D5FBG8MB3",
      "channel_name" => "directmessage",
      "command" => "/asap",
      "response_url" => "https://hooks.slack.com/commands/T03AK033D/231234562192/6rnGtBSGZDnrLCI5LU4PBy4I",
      "team_domain" => "someteam",
      "team_id" => "T03AK033D",
      "text" => "some_user some message",
      "token" => "ff9bcfd75b7e27010c6642de",
      "trigger_id" => "2222.3333.44444",
      "user_id" => "U54CURXRV",
      "user_name" => "sender"
    }

    The parameters contains the sender information.
  """
  def get_parameter(message, parameter_name),
    do: message.parameters[parameter_name]

  @doc """
    Get the receiver username parsed from the command message without @.
    Returns nil if it an invalid message
  """
  def get_username(message) do
    captures = Regex.named_captures(@regular_regex, message.parameters["text"])
    captures && captures["user"]
  end

  @doc """
    Get the receiver email got from the Slack Profile. Is nil if the username
    doesn't belong to the team, or if it is missing
  """
  def get_email(message),
    do: (message.profile["profile"] || %{})["email"]

  @doc """
    Gets information from the Receiver profile. Will yield nil if the username
    doesn't belong to the team, or the key is missing. An example profile is
    the following one:

    %{
      "deleted" => false,
      "id" => "UXXXXXXXX",
      "is_app_user" => true,
      "is_bot" => false,
      "name" => "foo",
      "profile" => %{
        "avatar_hash" => "574ef05b3285",
        "email" => "foo@example.com",
        "first_name" => "Franz",
        "image_1024" => "https://avatars.slack-edge.com/2002-01-01/67349247734_d41d8cd98f00b204e95_192.jpg",
        "image_192" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_192.jpg",
        "image_24" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_24.jpg",
        "image_32" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_32.jpg",
        "image_48" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_48.jpg",
        "image_512" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_192.jpg",
        "image_72" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_72.jpg",
        "image_original" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_original.jpg",
        "last_name" => "Oslvaldiz",
        "phone" => "55555555",
        "real_name" => "Franz Oslvaldiz",
        "real_name_normalized" => "Franz Oslvaldiz",
        "skype" => "Franz Oslvaldiz Skype",
        "team" => "T03LA94885",
        "title" => "Developer"},
        "team_id" => "T03LA94885",
        "updated" => 1000000000
      }
  """
  def get_profile_parameter(message, parameter_name),
    do: message.profile[parameter_name]

  @doc """
    Get the ASAP message parsed from the command
  """
  def get_asap_message(message) do
    captures = Regex.named_captures(@regular_regex, message.parameters["text"])
    captures && captures["message"]
  end

  @doc """
    Returns true if it is a help message (e.g. /asap help)
  """
  def is_help?(message),
    do: Regex.match?(@help_regex, message.parameters["text"])

  @doc """
    Makes a message invalid. Only valid messages are passed to handlers. Use
    this function to mark the message as failed to prevent further process
  """
  def fail(message),
    do: %{message | status: :fail}
end
