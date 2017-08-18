defmodule SlackAsapTest do
  use ExUnit.Case
  doctest SlackAsap

  import SlackAsap.Message
  import SlackAsap.Core
  alias SlackAsap.Message, as: Message

  test "should fail if no token is given in parameters" do
    assert %Message{} |> handle() |> is_ok? == false
  end

  test "fail message should be related to token" do
    assert (%Message{} |> handle()).text == "token validation failed"
  end

  test "should succeed with valid token" do
    right_token = Application.get_env(:slack_asap, :token)
    message = %Message{:parameters => %{ "token" => right_token }}

    assert message |> handle() |> is_ok? == true
  end

  test "should put a valid message if succeded" do
    right_token = Application.get_env(:slack_asap, :token)
    message = %Message{:parameters => %{ "token" => right_token }}

    assert (message |> handle()).text ==
      "We are sending the reminders. We will try to be as annoying as possible."
  end

end
