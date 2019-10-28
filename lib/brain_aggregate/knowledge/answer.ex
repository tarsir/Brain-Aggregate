defmodule BrainAggregate.Knowledge.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :contents, :string
    field :is_accepted, :boolean, default: false

    belongs_to(:question, BrainAggregate.Knowledge.Question)
    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:contents, :is_accepted])
    |> validate_required([:contents, :is_accepted])
  end
end
