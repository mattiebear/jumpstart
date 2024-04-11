# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jumpstart.Repo.insert!(%Jumpstart.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Jumpstart.Accounts.{Account, User}
alias Jumpstart.Repo

account =
  %Account{}
  |> Account.changeset(%{name: "Example Account"})
  |> Repo.insert!()

%User{}
|> User.registration_changeset(%{
  account_id: account.id,
  email: "user@example.com",
  password: "password1234"
})
|> Repo.insert!()
