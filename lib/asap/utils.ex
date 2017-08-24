defmodule SlackAsap.Utils do
  def get_config(key, parameter_name) do
    result = Application.get_env(:slack_asap, key)
    |> Enum.reverse()
    |> Enum.find(fn(element) -> elem(element, 0) == parameter_name end)
    elem(result || [], 1)
  end
end
