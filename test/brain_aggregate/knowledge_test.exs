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
end
