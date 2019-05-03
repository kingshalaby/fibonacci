defmodule Fibonacci do
  @moduledoc """
  Fibonacci keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def calculate(0), do: 0
  def calculate(1), do: 1

  def calculate(n), do: calculate(1, 0, n)

  def calculate(acc, _current, 1), do: acc
  def calculate(acc, current, n), do: calculate(acc + current, acc, n-1)
end
