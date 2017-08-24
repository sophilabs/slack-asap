defmodule SlackAsap.Message do
  defstruct [
      status: :ok,
      text: "",
      response_type: "in_channel",
      parameters: %{},
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

  def is_ok?(%{ :status => :ok }),
    do: true

  def is_ok?(_message),
    do: false

  def get_parameter(message, parameter_name),
    do: message.parameters[parameter_name]

  def get_username(message) do
    captures = Regex.named_captures(@regular_regex, message.parameters["text"])
    captures && captures["user"]
  end

  def get_asap_message(message) do
    captures = Regex.named_captures(@regular_regex, message.parameters["text"])
    captures && captures["message"]
  end

  def is_help?(message),
    do: Regex.match?(@help_regex, message.parameters["text"])

  def fail(message),
    do: %{message | status: :fail}
end
