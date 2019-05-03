defmodule FibonacciTest do
  use ExUnit.Case, async: true

  describe "calculate/1 " do
    test "it returns 1 when given 1" do
      assert Fibonacci.calculate(1) === 1
    end

    test "it returns 1 when given 2" do
      assert Fibonacci.calculate(2) === 1
    end

    test "it returns fibonacci number" do
      assert Fibonacci.calculate(10) === 55
    end

    test "it returns 354224848179261915075 given 100" do
      assert Fibonacci.calculate(100) === 354224848179261915075
    end
  end
end


