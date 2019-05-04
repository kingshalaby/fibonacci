defmodule FibonacciWeb.Api.IndexView do
  use FibonacciWeb, :view

  def render("calculate.json", %{fibonacci: number}) do
    %{fibonacci: number}
  end

  def render("history.json", %{history: results}) do
    %{history: render_many(results, __MODULE__, "entry.json")}
  end

  def render("history_count.json", %{history_count: result}) do
    %{history_count: result}
  end

  def render("entry.json", %{index: v}) do
    %{elem(v, 0) => elem(v, 1)}
  end
end
