defmodule Imunize.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :cep, :cpf, :rg, :password, :birth_day, :birth_month, :birth_year]

  @derive {Jason.Encoder, only: [:name, :cep, :cpf, :rg, :birth_day, :birth_month, :birth_year]}

  schema "users" do
    field :name, :string
    field :cep, :string
    field :cpf, :string
    field :rg, :string
    field :email, :string
    field :password, :string
    field :password_hash, :string
    field :birth_day, :integer
    field :birth_month, :integer
    field :birth_year, :integer

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:rg, is: 9)
    |> validate_number(:birth_day, greater_than_or_equal_to: 1)
    |> validate_number(:birth_month, greater_than_or_equal_to: 1)
    |> validate_number(:birth_year, greater_than_or_equal_to: 1921)
    |> validate_number(:birth_day, less_than_or_equal_to: 31)
    |> validate_number(:birth_month, less_than_or_equal_to: 12)
    # Necessário alterar para forma dinâmica
    |> validate_number(:birth_year, less_than_or_equal_to: 2021)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
