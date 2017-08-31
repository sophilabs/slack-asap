defmodule SlackAsap.TwilioSMS do
  import SlackAsap.Message
  import ExPhoneNumber
  import SlackAsap.Utils

  @adapter get_config(SlackAsap.TwilioSMS, :adapter)
  @default_country get_config(SlackAsap.TwilioSMS, :default_country)
  @from_phone_number get_config(SlackAsap.TwilioSMS, :phone_number)

  def get_sms_body(message) do
    sender = get_parameter(message, "user_name")
    msg = get_asap_message(message)
    "@#{sender}: #{msg} (by Slack ASAP)"
  end

  def handle(message) do
    {status, dest_phone_number } =
      get_profile_parameter(message, "phone") |> parse(@default_country)

    if status == :ok && is_valid_number?(dest_phone_number) do
      IO.inspect(@adapter.Message.create(%{
         from: @from_phone_number,
         to: format(dest_phone_number, :e164),
         body: get_sms_body(message)
      }))
    end
    message
  end
end
