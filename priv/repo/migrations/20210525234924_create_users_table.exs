defmodule Imunize.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :cep, :string
      add :cpf, :string
      add :rg, :string
      add :password_hash, :string
      add :birth_day, :integer
      add :birth_month, :integer
      add :birth_year, :integer

      timestamps()

    end
    create unique_index(:users, [:cpf])
    create unique_index(:users, [:rg])
    create unique_index(:users, [:rg])

  end
end
