defmodule Fibonacci.History do
  use Agent

  def start_link([]) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, & &1)
  end

  def add(value) do
    Agent.update(__MODULE__, fn state -> [value | state] end)
  end
end
