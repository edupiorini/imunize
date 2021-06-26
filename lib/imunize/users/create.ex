defmodule Imunize.Users.Create do
  alias Imunize.{Repo, User}

  def call(params) do
    params
    |> parse_datetime()
    |> User.changeset()
    |> Repo.insert()
    |> handle_call()
  end

  defp handle_call({:ok, %User{} = user}), do: {:ok, user}

  defp handle_call({:error, _reason}), do: {:error, "Some error"}

  defp parse_datetime(%{birthday: birthday} = params) do
    [year, month, day] = String.split(birthday, "-", trim: true)

    naive_date =
      NaiveDateTime.new!(
        String.to_integer(year),
        String.to_integer(month),
        String.to_integer(day),
        0,
        0,
        0
      )

    params
    |> Map.update(:birthday, naive_date, fn _old_value -> naive_date end)
  end
end
