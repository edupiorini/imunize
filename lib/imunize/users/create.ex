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

  def parse_datetime(%{"birthday" => birthday} = params) do
    naive_date =
      String.split(birthday, "-", trim: true)
      |> create_naive_datetime()

    params
    |> Map.update("birthday", naive_date, fn _old_value -> naive_date end)
  end

  defp create_naive_datetime([year, month, day]) do
    NaiveDateTime.new!(
      String.to_integer(year),
      String.to_integer(month),
      String.to_integer(day),
      0,
      0,
      0
    )
  end
end
