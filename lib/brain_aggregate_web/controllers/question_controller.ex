defmodule BrainAggregateWeb.QuestionController do
  use BrainAggregateWeb, :controller

  alias BrainAggregate.Knowledge
  alias BrainAggregate.Knowledge.Question

  def index(conn, _params) do
    questions = Knowledge.list_questions()
    render(conn, "index.html", questions: questions)
  end

  def ask_new(conn, _params) do
    changeset = Knowledge.change_question(%Question{})
    render(conn, :ask_new, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Knowledge.change_question(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"question" => question_params}) do
    case Knowledge.create_question(question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    {:ok, question} = Knowledge.get_question(id)
    render(conn, "show.html", question: question)
  end

  def edit(conn, %{"id" => id}) do
    question = Knowledge.get_question!(id)
    changeset = Knowledge.change_question(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Knowledge.get_question!(id)

    case Knowledge.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Knowledge.get_question!(id)
    {:ok, _question} = Knowledge.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: Routes.question_path(conn, :index))
  end
end
