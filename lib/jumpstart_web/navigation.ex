defmodule JumpstartWeb.Navigation do
  def parse_path(path) do
    path |> URI.parse() |> Map.get(:path)
  end

  # TODO: Make this better
  def build_navigation(url) do
    path = parse_path(url)

    %{
      dashboard: path == "/dashboard",
      translate: Regex.match?(~r/\/translate/, path),
      translate_dashboard: path == "/translate",
      translate_translations: path == "/translate/namespaces",
      translate_users: path == "/translate/users",
      translate_settings: path == "/translate/settings",
      translate_developer: path == "/translate/developer",
      account: path == "/account"
    }
  end
end
