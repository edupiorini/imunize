defmodule Imunize.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :cep, :string
      add :cpf, :string
      add :email, :string
      add :rg, :string
      add :password_hash, :string
      add :birthday, :naive_datetime

      timestamps()
    end

    create unique_index(:users, [:cpf])
    create unique_index(:users, [:rg])
    create unique_index(:users, [:email])
  end
end
