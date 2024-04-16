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
alias Jumpstart.{Projects, Translate}

account =
  %Account{}
  |> Account.changeset(%{name: "Example Account"})
  |> Repo.insert!()

Projects.create_project_on_account(account.id, %{name: "My Project"})

Translate.create_settings_on_account(account.id, %{
  source_locale: "en",
  locales: [
    %{code: "en", name: "English"},
    %{code: "es", name: "Spanish"},
    %{code: "fr", name: "French"}
  ]
})

%User{}
|> User.registration_changeset(%{
  email: "user@example.com",
  password: "password1234"
})
|> Ecto.Changeset.put_assoc(:account, account)
|> Repo.insert!()
