defmodule Fibonacci do
  @moduledoc """
  Fibonacci keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Fibonacci.Cache

  def calculate(0), do: 0
  def calculate(1), do: 1

  def calculate(arg) when is_list(arg) do
    arg
    |> Enum.reduce([], fn n, acc -> [calculate(n) | acc] end)
    |> Enum.reverse
  end

  def calculate(n) do
    case Cache.get(n) do
      nil ->
        value = calculate(1, 0, n)
        Cache.set(n, value)
      value ->
        value
    end

  end

  defp calculate(acc, _current, 1), do: acc
  defp calculate(acc, current, n), do: calculate(acc + current, acc, n-1)
end
