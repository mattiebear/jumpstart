defmodule Jumpstart.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jumpstart.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    account = account_fixture()

    {:ok, user} =
      attrs
      |> Enum.into(%{
        account_id: account.id
      })
      |> valid_user_attributes()
      |> Jumpstart.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Jumpstart.Accounts.create_account()

    account
  end
end
