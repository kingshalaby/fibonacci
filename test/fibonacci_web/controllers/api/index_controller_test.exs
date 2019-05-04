defmodule FibonacciWeb.API.IndexControllerTest do
  use FibonacciWeb.ConnCase, async: false
  use ExUnit.Case
  alias Fibonacci.History

  describe "GET /api/calculate/:number" do
    test "returns valid response when given integer", %{conn: conn} do
      conn =
        conn
        |> get("/api/fibonacci/calculate/7")

      assert json_response(conn, 202)["fibonacci"] == 13
    end

    test "returns error response when given non integer", %{conn: conn} do
      conn =
        conn
        |> get("/api/fibonacci/calculate/text")

      assert json_response(conn, 400)
    end
  end

  describe "GET /api/fibonacci/history" do
    test "returns valid response when given integer", %{conn: conn} do
      Agent.update(History, fn _state -> [] end)

      History.add({5, 5})
      History.add({5, 5})
      History.add({7, 13})

      expected = [%{"5" => 5}, %{"5" => 5}, %{"7" => 13}]

      conn =
        conn
        |> get("/api/fibonacci/history")

      assert json_response(conn, 200)["history"] == expected
    end
  end

  describe "GET /api/fibonacci/history_count" do
    test "returns valid response when given integer", %{conn: conn} do
      Agent.update(History, fn _state -> [] end)

      History.add({5, 5})
      History.add({5, 5})
      History.add({7, 13})

      expected = %{"5" => 2, "7" => 1}

      conn =
        conn
        |> get("/api/fibonacci/history_count")

      assert json_response(conn, 200)["history_count"] == expected
    end
  end
end
