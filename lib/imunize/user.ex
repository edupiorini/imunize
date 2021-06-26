defmodule Imunize.User do
  @moduledoc """
  Schema for user definition and changeset
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [
    :name,
    :cep,
    :email,
    :cpf,
    :rg,
    :password,
    :birthday
  ]

  @derive {Jason.Encoder, only: [:id, :name, :email, :cep, :cpf, :rg]}

  schema "users" do
    field :name, :string
    field :cep, :string
    field :cpf, :string
    field :rg, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :birthday, :naive_datetime

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
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  @spec put_password_hash(%Changeset{}) :: String.t()
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset

  # def create_date(%Changeset{
  #       valid?: true,
  #       changes:
  #         %{
  #           birthday: _birthday,
  #           birth_day: birth_day,
  #           birth_yearh: birth_year,
  #           birth_month: birth_month
  #         } = changeset
  #     }) do
  #   new_date = Date.new!(birth_year, birth_month, birth_day)

  #   changeset
  #   |> Map.replace(:birthday, new_date)
  # end
end
