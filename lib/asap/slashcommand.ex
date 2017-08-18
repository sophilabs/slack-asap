defmodule SlackAsap.Command do
  defp put_text([status, message], text),
    do: [status, Map.put(message, "text", text)]

  def put_type([:ok, message]),
    do: [:ok, Map.put(message, "response_type", "ephemeral")]

  def put_type([_, message]),
      do: [:fail, message]

  def verify_token([:ok, message]) do
    if message["token"] == Application.get_env(:slack_asap, :token) do
      [:ok, message]
    else
      put_text([:fail, message], "token validation failed")
    end
  end

  def verify_token([_, message]) do
    [:fail, message]
  end

  def make_response([:ok, message]) do
    put_text(
      [:ok, message],
      "We are sending the reminders. We will try to be as annoying as possible."
    )
  end

  def make_response([_, message]),
    do: [:fail, message]

  def handle(params) do
    [_status, response] = [:ok, params]
      |> put_type()
      |> verify_token()
      |> make_response()

    response
  end
end
