defmodule JumpstartWeb.Navigation do
  def assign_navigation(socket, url) do
    Phoenix.Component.assign(socket, :navigation, build_navigation(url))
  end

  # TODO: Make this better
  defp build_navigation(url) do
    path = parse_path(url)

    %{
      dashboard: path == "/dashboard",
      translate: Regex.match?(~r/\/translate/, path),
      translate_dashboard: path == "/translate",
      translate_translations: Regex.match?(~r/\/translate\/namespaces/, path),
      translate_users: path == "/translate/users",
      translate_settings: path == "/translate/settings",
      translate_developer: path == "/translate/developer",
      account: path == "/account"
    }
  end

  defp parse_path(path) do
    path |> URI.parse() |> Map.get(:path)
  end
end
