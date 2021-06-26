defmodule Imunize.Users.Create do
  alias Imunize.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_call()
  end

  defp handle_call({:ok, %User{} = user}), do: {:ok, user}

  defp handle_call({:error, _reason}), do: {:error, "Some error"}
end
