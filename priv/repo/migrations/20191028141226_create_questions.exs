defmodule BrainAggregate.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :title, :string
      add :contents, :string

      timestamps()
    end

  end
end
