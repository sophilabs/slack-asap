defmodule SlackAsap.Command do
  import SlackAsap.Message

  def notifier_handle_message([handler | t], message) do
    if is_ok? message do
      notifier_handle_message(t, handler.handle(message))
    else
      message
    end
  end

  def notifier_handle_message([], message) do
    message
  end

  def get_notifiers() do
    [ SlackAsap.Core ] ++ Application.get_env(:slack_asap, :notifiers)
  end

  def handle(params) do
    processed = notifier_handle_message(
      get_notifiers(),
      %SlackAsap.Message{:parameters => params}
    )

    %{
      "response_type" => processed.response_type,
      "text" => processed.text
    }
  end
end
