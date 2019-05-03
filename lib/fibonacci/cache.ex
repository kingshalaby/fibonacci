defmodule Fibonacci.Cache do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get(key) do
    case GenServer.call(__MODULE__, {:get, key}) do
      [] -> nil
      [{_key, result}] -> result
    end
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  # GenServer callbacks

  def handle_call({:get, key}, _from, state) do
    result = :ets.lookup(:fib_cache, key)
    {:reply, result, state}
  end

  def handle_call({:set, key, value}, _from, state) do
    true = :ets.insert(:fib_cache, {key, value})
    {:reply, value, state}
  end

  def init(state) do
    :ets.new(:fib_cache, [:set, :protected, :named_table])
    {:ok, state}

  end
end
