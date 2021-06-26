defmodule ImunizeWeb.UsersView do
  @moduledoc """
  Renders information coming from Controller to API as json file
  """
  use ImunizeWeb, :view

  alias Imunize.User

  def render("create.json", %{
        user:
          %User{
            name: name,
            cep: cep,
            rg: rg,
            cpf: cpf,
            email: email,
            id: id,
            birthday: birthday
          } = _user
      }) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        cep: cep,
        rg: rg,
        cpf: cpf,
        email: email,
        birthday: Date.to_string(birthday)
      }
    }
  end
end
