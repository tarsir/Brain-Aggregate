defmodule BrainAggregateWeb.Router do
  use BrainAggregateWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BrainAggregateWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/questions", QuestionController
    get "/ask_new", QuestionController, :ask_new
    get "/answer/:question_id", AnswerController, :new
    post "/answer/:question_id", AnswerController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", BrainAggregateWeb do
  #   pipe_through :api
  # end
end
