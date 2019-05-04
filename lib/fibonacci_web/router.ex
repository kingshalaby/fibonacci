defmodule FibonacciWeb.Router do
  use FibonacciWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api/fibonacci", FibonacciWeb.Api, as: :api do
    pipe_through(:api)
    get("/calculate/:number", IndexController, :calculate)
    get("/history", IndexController, :history)
    get("/history_count", IndexController, :history_count)
  end
end
