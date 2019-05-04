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
      assert Fibonacci.calculate(100) === 354_224_848_179_261_915_075
    end

    test "it returns a list of fibonacci results when given a list of numbers" do
      assert Fibonacci.calculate([1, 10, 100]) === [1, 55, 354_224_848_179_261_915_075]
    end
  end

  describe "history/0" do
    test "it returns a list of tuples holding previously requested numbers and their results" do
      Agent.update(Fibonacci.History, fn _state -> [] end)
      assert Fibonacci.history() === []

      assert Fibonacci.calculate(10) === 55
      assert Fibonacci.calculate(2) === 1
      assert Fibonacci.calculate([1, 10, 100]) === [1, 55, 354_224_848_179_261_915_075]

      expected = [
        {10, 55},
        {2, 1},
        {[1, 10, 100], [1, 55, 354_224_848_179_261_915_075]}
      ]

      assert Fibonacci.history() === expected
    end
  end

  describe "history_count/0" do
    test "it returns a map with previously requested numbers with count of requests" do
      Agent.update(Fibonacci.History, fn _state -> [] end)
      assert Fibonacci.history_count() === %{}

      assert Fibonacci.calculate(10) === 55
      assert Fibonacci.calculate(7) === 13
      assert Fibonacci.calculate(10) === 55

      expected = %{10 => 2, 7 => 1}

      assert Fibonacci.history_count() === expected
    end
  end
end
