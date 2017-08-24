# Using the mailer from the Getting Started section
defmodule SlackAsapTest.BambooEmail do
  use ExUnit.Case
  use Bamboo.Test

  import SlackAsap.Message
  import SlackAsap.BambooEmail

  alias SlackAsap.Message, as: Message

  test "unknown email returns nil" do
    assert get_email("some_user") == nil
  end

  test "known email is treated ok" do
    assert get_email("foo") == "foo@example.com"
  end

  test "build_email" do
    email = build("foo@example.com", "Some message")
    assert email.to == "foo@example.com"
    assert email.from == Application.get_env(:slack_asap, SlackAsap.BambooEmail).email_from
    assert email.html_body =~  "Some message"
  end

  test "handling a known user sends an email" do
    assert %Message{parameters: %{"text" => "foo some message"}}
      |> handle()
      |> is_ok? == true

    assert_delivered_with(to: [nil: "foo@example.com"])
  end

  test "handling an unknown user doesn't send an email" do
    assert %Message{parameters: %{"text" => "bar some message"}}
      |> handle()
      |> is_ok? == true

    assert_no_emails_delivered
  end
end
