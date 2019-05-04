defmodule Fibonacci.CacheTest do
  use ExUnit.Case, async: true

  test "ETS get and set" do
    assert Fibonacci.Cache.get(10) == nil

    Fibonacci.Cache.set(10, 55)
    assert Fibonacci.Cache.get(10) == 55
  end
end
