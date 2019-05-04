defmodule Fibonacci do
  @moduledoc """
  this module is the internal API to `calculate/1` fibonacci and show `history/0` and `history_count/0`
  """
  alias Fibonacci.{History, Cache}

  @doc """
  calculates fabonacci for a specific number

  ## Example
      iex> Fibonacci.calculate(10)
      55

      iex> Fibonacci.calculate(100)
      354224848179261915075

  it also can talk a list of numbers as a single argument, and return a list of fibonacci results in the same order of entry

  ## Ecample
      iex> Fibonacci.calculate([0, 1, 100])
      [0, 1, 354224848179261915075]

  """
  @spec calculate(integer() | list(integer())) :: integer() | list(integer())
  def calculate(arg) do
    value =
      case Cache.get(arg) do
        nil ->
          value = do_calculate(arg)
          Cache.set(arg, value)

        value ->
          value
      end

    historify({arg, value})

    value
  end

  @doc """
  returns a list of maps having their keys are previously requested number, and values are request counts

  ## Example
      iex> Fibonacci.history_count
      %{10 => 1, 100 => 1, [0, 1, 100] => 1}


  """
  @spec history_count() :: list(%{}) | %{}
  def history_count() do
    History.get()
    |> Enum.reduce(%{}, fn {k, _v}, acc -> Map.update(acc, k, 1, &(&1 + 1)) end)
  end

  @doc """
  returns a list of tuples holding previously requested numbers and their results, in the same order they were requested

  ## Example
      iex> Fibonacci.history
      [
        {10, 55},
        {100, 354224848179261915075},
        {[0, 1, 100], [0, 1, 354224848179261915075]}
      ]

  """
  @spec history() :: list(tuple()) | []
  def history() do
    History.get() |> Enum.reverse()
  end

  ## internal functions
  @doc false

  defp historify(entry), do: History.add(entry)

  defp do_calculate(0), do: 0
  defp do_calculate(1), do: 1

  defp do_calculate(arg) when is_list(arg) do
    arg
    |> Enum.reduce([], fn n, acc -> [do_calculate(n) | acc] end)
    |> Enum.reverse()
  end

  defp do_calculate(n) when not is_list(n), do: do_calculate(1, 0, n)

  defp do_calculate(acc, _current, 1), do: acc
  defp do_calculate(acc, current, n), do: do_calculate(acc + current, acc, n - 1)
end
