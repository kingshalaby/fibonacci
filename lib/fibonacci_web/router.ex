defmodule FibonacciWeb.Router do
  use FibonacciWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", FibonacciWeb do
    pipe_through(:api)
  end
end
