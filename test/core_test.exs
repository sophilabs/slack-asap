defmodule SlackAsapTest.Core do
  use ExUnit.Case
  doctest SlackAsap

  import SlackAsap.Message
  import SlackAsap.Core
  alias SlackAsap.Message, as: Message

  @right_token Application.get_env(:slack_asap, :token)

  @doc """
    Build a well formed message with profile information. Ready for other
    Notifiers
  """
  def wellformed_message() do
    message = %Message{
      parameters: %{ "token" => @right_token, "text" => "foo message" }
    }
    message |> handle()
  end

  test "should fail if no token is given in parameters" do
    assert %Message{parameters: %{"text" => ""}} |> handle() |> is_ok? == false
  end

  test "fail message should be related to token" do
    assert (
      %Message{parameters: %{"text" => ""}} |> handle()
    ).text == "token validation failed"
  end

  test "should succeed with valid token" do
    message = %Message{parameters: %{ "token" => @right_token, "text" => "" }}

    assert message |> handle() |> is_ok? == true
  end

  test "should put a help message" do
    message = %Message{parameters: %{ "token" => @right_token, "text" => "" }}

    assert String.contains?((message |> handle()).text, "asap") == true
  end

  test "should put a confirmation message" do
    message = %Message{
      parameters: %{ "token" => @right_token, "text" => "user message" }
    }

    assert String.contains?((message |> handle()).text, "annoying") == true
  end

  test "should fill the profile information" do
     message = %Message{
       parameters: %{ "token" => @right_token, "text" => "foo mesage" }
     }

     assert (message |> handle()).profile != %{}
     assert message |> handle() |> get_profile_parameter("name") == "foo"
  end
end
