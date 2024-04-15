defmodule Jumpstart.Translate do
  @moduledoc """
  The Translate context.
  """

  import Ecto.Query, warn: false
  alias Jumpstart.Repo

  alias Jumpstart.Translate.TranslateSettings

  def create_settings_on_account(account_id, attrs \\ %{}) do
    %TranslateSettings{account_id: account_id}
    |> TranslateSettings.changeset(attrs)
    |> Repo.insert()
  end
end
