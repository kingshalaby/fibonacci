defmodule Fibonacci do
  @moduledoc """
  Fibonacci keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def calculate(1), do: 1
  def calculate(2), do: 1
  def calculate(n) do
    calculate(n-1) + calculate (n-2)
  end
end
