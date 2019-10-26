defmodule BrainAggregateWeb.PageController do
  use BrainAggregateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
