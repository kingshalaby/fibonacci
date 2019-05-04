defmodule FibonacciWeb.Api.ErrorView do
  use FibonacciWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end
