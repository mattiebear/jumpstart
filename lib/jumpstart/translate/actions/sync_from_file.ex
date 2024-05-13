defmodule Jumpstart.Translate.Actions.SyncFromFile do
  alias Jumpstart.Translate
  alias Jumpstart.Repo
  alias Jumpstart.Projects.Project
  alias Jumpstart.Translate.{Namespace, Phrase, Translation}

  def run(entry, path, project) do
    # with
    #    {:ok, {source, targets}} <- split_project_locales(project),
    #    {:ok, name} <- get_namespace_name(entry.client_name),
    #    {:ok, namespace} <- get_namespace(name, project_id),
    #    {:ok, contents} <- File.read(path),
    #    {:ok, json} <- Jason.decode(contents),
    #    {:ok, list} <- Dotmap.contract(json),
    #    {:ok, data} <- sync_translations(list, namespace, source, targets) do
    # {:ok, list}
    # else
    #   {:error, _} -> {:error, "Failed to sync translations"}
    # end
  end

  # defp split_project_locales(project) do
  #   source = Enum.find(project.locales, & &1.is_source)
  #   targets = Enum.reject(project.locales, & &1.is_source)

  #   {:ok, {source, targets}}
  # end

  # defp get_namespace_name(filename) do
  #   namespace_name =
  #     filename
  #     |> Path.basename()
  #     |> Path.rootname()

  #   {:ok, namespace_name}
  # end

  # defp get_namespace(namespace_name, project_id) do
  #   case Repo.get_by(Namespace, name: namespace_name, project_id: project_id) do
  #     nil ->
  #       %Namespace{project_id: project_id}
  #       |> Namespace.changeset(%{name: namespace_name})
  #       |> Repo.insert()

  #     namespace ->
  #       namespace = Repo.preload(namespace, phrases: [:translations])
  #       {:ok, namespace}
  #   end
  # end

  # defp sync_translations(list, namespace, source, targets) do
  #   Enum.map(list, fn {key, value} ->
  #     nil
  #     # Translate.Actions.SyncPhrase()
  #   end)

  #   # determine the source locale
  #   # iterate through the list
  #   # find the phrase of the source translation in the namespace
  #   # if it exists check if the text is the s
  #   {:ok, []}
  # end
end
