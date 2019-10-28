defmodule BrainAggregate.Knowledge.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :contents, :string
    field :title, :string

    has_many(:answers, BrainAggregate.Knowledge.Answer)
    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:title, :contents])
    |> validate_required([:title, :contents])
  end
end
