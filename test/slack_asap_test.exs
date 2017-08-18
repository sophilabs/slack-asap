defmodule SlackAsapTest do
  use ExUnit.Case
  doctest SlackAsap

  test "greets the world" do
    assert SlackAsap.hello() == :world
  end
end
