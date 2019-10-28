defmodule BrainAggregate.KnowledgeTest do
  use BrainAggregate.DataCase

  alias BrainAggregate.Knowledge

  describe "questions" do
    alias BrainAggregate.Knowledge.Question

    @valid_attrs %{contents: "some contents", title: "some title"}
    @update_attrs %{contents: "some updated contents", title: "some updated title"}
    @invalid_attrs %{contents: nil, title: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Knowledge.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Knowledge.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Knowledge.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Knowledge.create_question(@valid_attrs)
      assert question.contents == "some contents"
      assert question.title == "some title"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Knowledge.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Knowledge.update_question(question, @update_attrs)
      assert question.contents == "some updated contents"
      assert question.title == "some updated title"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Knowledge.update_question(question, @invalid_attrs)
      assert question == Knowledge.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Knowledge.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Knowledge.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Knowledge.change_question(question)
    end
  end

  describe "answers" do
    alias BrainAggregate.Knowledge.Answer

    @valid_attrs %{contents: "some contents", is_accepted: true}
    @update_attrs %{contents: "some updated contents", is_accepted: false}
    @invalid_attrs %{contents: nil, is_accepted: nil}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Knowledge.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Knowledge.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Knowledge.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = Knowledge.create_answer(@valid_attrs)
      assert answer.contents == "some contents"
      assert answer.is_accepted == true
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Knowledge.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{} = answer} = Knowledge.update_answer(answer, @update_attrs)
      assert answer.contents == "some updated contents"
      assert answer.is_accepted == false
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Knowledge.update_answer(answer, @invalid_attrs)
      assert answer == Knowledge.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Knowledge.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Knowledge.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Knowledge.change_answer(answer)
    end
  end
end
