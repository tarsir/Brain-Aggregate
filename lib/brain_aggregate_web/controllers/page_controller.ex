defmodule BrainAggregateWeb.PageController do
  use BrainAggregateWeb, :controller
  alias BrainAggregate.Knowledge

  def index(conn, _params) do
    hot_questions = Knowledge.list_questions()

    render(conn, "index.html", hot_questions: hot_questions)
  end
end
