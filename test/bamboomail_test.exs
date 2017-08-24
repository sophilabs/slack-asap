# Using the mailer from the Getting Started section
defmodule SlackAsapTest.BambooEmail do
  use ExUnit.Case
  use Bamboo.Test

  import SlackAsap.Message
  import SlackAsap.BambooEmail

  alias SlackAsap.Message, as: Message

  test "build_email" do
    email = build("foo@example.com", "Some message")
    assert email.to == "foo@example.com"
    assert email.from == "slack_asap@sophilabs.com"
    assert email.html_body =~  "Some message"
  end

  test "handling a known user sends an email" do
    assert SlackAsapTest.Core.wellformed_message()
      |> handle()
      |> is_ok? == true

    assert_delivered_with(to: [nil: "foo@example.com"])
  end

  test "handling an unknown user doesn't send an email" do
    assert %Message{parameters: %{"text" => "bar some message"}}
      |> handle()
      |> is_ok? == true

    assert_no_emails_delivered()
  end
end
