defmodule FibonacciWeb.Api.IndexController do
  use FibonacciWeb, :controller

  alias FibonacciWeb.Api.ErrorView

  def calculate(conn, %{"number" => number}) do
    case Integer.parse(number) do
      {intger, _} ->
        result = Fibonacci.calculate(intger)

        conn
        |> put_status(:accepted)
        |> render("calculate.json", fibonacci: result)

      _ ->
        conn
        |> put_status(:bad_request)
        |> put_view(ErrorView)
        |> render("error.json", errors: "Bad request")
    end
  end

  def history(conn, _params) do
    result = Fibonacci.history()

    conn
    |> put_status(:ok)
    |> render("history.json", history: result)
  end

  def history_count(conn, _params) do
    result = Fibonacci.history_count()

    conn
    |> put_status(:ok)
    |> render("history_count.json", history_count: result)
  end
end
