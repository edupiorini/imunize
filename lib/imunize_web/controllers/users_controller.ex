defmodule ImunizeWeb.UsersController do
  @moduledoc """
  Controller build information comming from Imunize and send it to
  View for rendering
  """

  use ImunizeWeb, :controller

  alias Imunize.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Imunize.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
