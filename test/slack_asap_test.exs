defmodule SlackAsapTest do
  use ExUnit.Case
  doctest SlackAsap

  test "verify_token fails with no token" do
    [status, _message] = SlackAsap.Command.verify_token([:ok, %{}])
    assert status == :fail
  end

  test "verify_token fail message is correct" do
    [_status, message] = SlackAsap.Command.verify_token([:ok, %{}])
    assert message["text"] == "token validation failed"
  end

  test "verify_token succeds with correct token" do
    [status, _message] = SlackAsap.Command.verify_token([:ok, %{
      "token" => Application.get_env(:slack_asap, :token)
    }])
    assert status == :ok
  end

  test "verify_token succeds with incorrect token" do
    [status, _message] = SlackAsap.Command.verify_token([:ok, %{
      "token" => "some random token"
    }])
    assert status == :fail
  end

  test "verify_token should fail with invalid status" do
    [status, _message] = SlackAsap.Command.verify_token([:something, %{}])
    assert status == :fail
  end

  test "make_response should put the message" do
    [status, message] = SlackAsap.Command.make_response([:ok, %{}])
    assert status == :ok
    assert Map.has_key?(message, "text")
  end

  test "make_response should fail with invalid status" do
    [status, _message] = SlackAsap.Command.make_response([:something, %{}])
    assert status == :fail
  end

  test "put_type should put the type" do
    [status, message] = SlackAsap.Command.put_type([:ok, %{}])
    assert status == :ok
    assert message["response_type"] == "ephemeral"
  end

  test "put_type should fail with invalid status" do
    [status, _message] = SlackAsap.Command.put_type([:something, %{}])
    assert status == :fail
  end
end
