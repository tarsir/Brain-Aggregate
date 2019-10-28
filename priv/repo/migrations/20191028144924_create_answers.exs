defmodule BrainAggregate.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :contents, :string
      add :is_accepted, :boolean, default: false, null: false
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:question_id])
  end
end
