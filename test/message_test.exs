defmodule SlackAsapMessageTest do
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

  test "put_type should put the type" do
    assert put_type(%Message{}, "something").response_type == "something"
  end

  test "get_parameter should get the right parameter" do
    assert get_parameter(%Message{ parameters: %{"foo" => "bar"}}, "foo") == "bar"
  end
end
