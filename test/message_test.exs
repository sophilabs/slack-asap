defmodule SlackAsapTest.Message do
  use ExUnit.Case

  import SlackAsap.Message
  alias SlackAsap.Message, as: Message

  doctest SlackAsap

  test "Message Ok" do
    assert is_ok?(%Message{}) == true
  end

  test "Message Fails" do
    assert is_ok?(%Message{:status => :fail}) == false
  end

  test "fails should make it fails" do
    assert %Message{} |> fail() |> is_ok? == false
  end

  test "put_text should put the text" do
    assert put_text(%Message{}, "something").text == "something"
  end

  test "Empty message has no attachments" do
      assert Enum.empty?(%Message{}.attachments) == true
  end

  test "Adds a text attachment" do
      message = %Message{} |> add_text_attachment("Hello")
      assert Enum.empty?(message.attachments) == false
      assert Enum.at(message.attachments, 0) == %{ text: "Hello" }
  end

  test "put_type should put the type" do
    assert put_type(%Message{}, :in_channel).response_type == "in_channel"
    assert put_type(%Message{}, :ephemeral).response_type == "ephemeral"
  end

  test "get_parameter should get the right parameter" do
    assert get_parameter(%Message{ parameters: %{"foo" => "bar"}}, "foo") == "bar"
  end

  test "get_user" do
    assert %Message{ parameters: %{"text" => "the_user the_message"} }
      |> get_username() == "the_user"

    assert %Message{ parameters: %{"text" => "@the_user the_message"} }
      |> get_username() == "the_user"

    assert %Message{ parameters: %{"text" => "  @the_user the message "} }
      |> get_username() == "the_user"

    assert %Message{ parameters: %{"text" => "invalid_message"} }
      |> get_username() == nil
  end

  test "get_message" do
    assert %Message{ parameters: %{"text" => "the_user the_message"} }
      |> get_asap_message() == "the_message"

    assert %Message{ parameters: %{"text" => "@the_user the_message"} }
      |> get_asap_message() == "the_message"

    assert %Message{ parameters: %{"text" => "  @the_user the message "} }
      |> get_asap_message() == "the message "

    assert %Message{ parameters: %{"text" => "invalid_message"} }
      |> get_asap_message() == nil
  end

  test "is_help?" do
    assert %Message{ parameters: %{"text" => "invalid_message"} }
      |> is_help?() == false

    assert %Message{ parameters: %{"text" => "help"} }
      |> is_help?() == true

    assert %Message{ parameters: %{"text" => "HELP "} }
      |> is_help?() == true

    assert %Message{ parameters: %{"text" => "usage"} }
      |> is_help?() == true

    assert %Message{ parameters: %{"text" => ""} }
      |> is_help?() == true
  end

  test "unknown email returns nil" do
    assert %Message{ profile: %{} }
      |> get_email() == nil
  end

  test "known email is treated ok" do
    assert %Message{ profile: %{ "profile" => %{ "email" => "foo@bar.com"} }}
      |> get_email() == "foo@bar.com"
  end
end
