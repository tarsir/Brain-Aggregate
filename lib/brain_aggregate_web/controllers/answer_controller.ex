defmodule BrainAggregateWeb.AnswerController do
  use BrainAggregateWeb, :controller

  alias BrainAggregate.Knowledge
  alias BrainAggregate.Knowledge.{Answer, Question}

  def index(conn, _params) do
    answers = Knowledge.list_answers()
    render(conn, "index.html", answers: answers)
  end

  def new(conn, %{"question_id" => question_id}) do
    case Knowledge.get_question(question_id) do
      {:ok, question} ->
        changeset = Knowledge.change_answer(%Answer{})
        render(conn, :add_answer, changeset: changeset, question: question)
      {:error, :no_results} ->
        no_question_found_redirect(conn)
    end
  end
  
  def add_answer(conn, _params) do
    conn
    |> put_flash(:error, "You took a wrong turn somewhere...Try again!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def create(conn, %{"question_id" => question_id, "answer" => answer_params}) do
    with {:ok, question} <- Knowledge.get_question(question_id),
         {:ok, answer} <- Knowledge.create_answer(question.id, answer_params) do
      conn
      |> put_flash(:info, "Answer created successfully.")
      |> redirect(to: Routes.question_path(conn, :show, question.id))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :add_answer, changeset: changeset)
      {:error, :no_results} ->
        no_question_found_redirect(conn)
    end
  end

  def create(conn, _params) do
    conn
    |> put_flash(:error, "You took a wrong turn somewhere...Try again!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    answer = Knowledge.get_answer!(id)
    render(conn, "show.html", answer: answer)
  end

  def edit(conn, %{"id" => id}) do
    answer = Knowledge.get_answer!(id)
    changeset = Knowledge.change_answer(answer)
    render(conn, "edit.html", answer: answer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Knowledge.get_answer!(id)

    case Knowledge.update_answer(answer, answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer updated successfully.")
        |> redirect(to: Routes.answer_path(conn, :show, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", answer: answer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Knowledge.get_answer!(id)
    {:ok, _answer} = Knowledge.delete_answer(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: Routes.answer_path(conn, :index))
  end

  defp no_question_found_redirect(conn) do
    conn
    |> put_flash(:error, "That seems to be an invalid question to answer.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
