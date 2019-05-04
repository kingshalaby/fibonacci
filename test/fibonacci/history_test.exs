defmodule Fibonacci.HistoryTest do
  use ExUnit.Case, async: false
  alias Fibonacci.History

  setup do
    Agent.update(History, fn _state -> [] end)
  end

  test "agent get and set" do
    assert History.get() === []

    entry = {10, 55}
    History.add(entry)
    assert History.get() === [entry]
  end
end
