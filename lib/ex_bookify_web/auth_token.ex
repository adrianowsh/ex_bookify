defmodule ExBookifyWeb.AuthToken do
  @user_salt "asdf"

  @doc """
  Encodes the given `user` id and signs it, returning a token
  clients can use as identification when using the API.
  """
  def sign(user) do
    Phoenix.Token.sign(ExBookifyWeb.Endpoint, @user_salt, %{id: user.id})
  end

  @doc """
  Decodes the original data from the given `token` and
  verifies its integrity.
  """
  def verify(token) do
    Phoenix.Token.verify(ExBookifyWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 3600)
  end
end
