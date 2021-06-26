defmodule ImunizeWeb.UsersView do
  @moduledoc """
  Renders information coming from Controller to API as json file
  """
  use ImunizeWeb, :view

  alias Imunize.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created!",
      user: user
    }
  end
end
