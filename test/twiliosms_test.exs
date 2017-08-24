defmodule SlackAsapTest.TwilioSMS do
  use ExUnit.Case

  import SlackAsap.TwilioSMS
  import SlackAsap.Message

  test "handling a good phone sends an sms" do
    assert SlackAsapTest.Core.wellformed_message()
      |> handle()
      |> is_ok?() == true
  end
end
