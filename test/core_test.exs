defmodule SlackAsapTest do
  use ExUnit.Case
  doctest SlackAsap

  import SlackAsap.Message
  import SlackAsap.Core
  alias SlackAsap.Message, as: Message

  test "should fail if no token is given in parameters" do
    assert %Message{parameters: %{"text" => ""}} |> handle() |> is_ok? == false
  end

  test "fail message should be related to token" do
    assert (
      %Message{parameters: %{"text" => ""}} |> handle()
    ).text == "token validation failed"
  end

  test "should succeed with valid token" do
    right_token = Application.get_env(:slack_asap, :token)
    message = %Message{parameters: %{ "token" => right_token, "text" => "" }}

    assert message |> handle() |> is_ok? == true
  end

  test "should put a help message" do
    right_token = Application.get_env(:slack_asap, :token)
    message = %Message{parameters: %{ "token" => right_token, "text" => "" }}

    assert String.contains?((message |> handle()).text, "asap") == true
  end

  test "should put a confirmation message" do
    right_token = Application.get_env(:slack_asap, :token)
    message = %Message{parameters: %{ "token" => right_token, "text" => "user message" }}

    assert String.contains?((message |> handle()).text, "annoying") == true
  end
end
