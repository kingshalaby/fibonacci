defmodule Fibonacci do
  @moduledoc """
  Fibonacci keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Fibonacci.{History, Cache}

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

  def history_count() do
    History.get()
    |> Enum.reduce(%{}, fn {k, _v}, acc -> Map.update(acc, k, 1, &(&1 + 1)) end)
  end

  def history() do
    History.get() |> Enum.reverse()
  end

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
