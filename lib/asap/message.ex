defmodule SlackAsap.Message do
  defstruct [
      status: :ok,
      text: "",
      response_type: "in_channel",
      parameters: %{},
  ]

  def put_text(message, text),
    do: %{message | text: text}

  def put_type(message, response_type),
    do: %{message | response_type: response_type}

  def is_ok?(%{ :status => :ok }),
    do: true

  def is_ok?(_message),
    do: false

  def get_parameter(message, parameter_name),
    do: message.parameters[parameter_name]

  def fail(message),
    do: %{message | status: :fail}
end
