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

  alias Jumpstart.Translate.Locale

  @doc """
  Returns the list of locales.

  ## Examples

      iex> list_locales()
      [%Locale{}, ...]

  """
  def list_locales do
    Repo.all(Locale)
  end

  @doc """
  Gets a single locale.

  Raises `Ecto.NoResultsError` if the Locale does not exist.

  ## Examples

      iex> get_locale!(123)
      %Locale{}

      iex> get_locale!(456)
      ** (Ecto.NoResultsError)

  """
  def get_locale!(id), do: Repo.get!(Locale, id)

  @doc """
  Creates a locale.

  ## Examples

      iex> create_locale(%{field: value})
      {:ok, %Locale{}}

      iex> create_locale(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_locale(attrs \\ %{}) do
    %Locale{}
    |> Locale.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a locale.

  ## Examples

      iex> update_locale(locale, %{field: new_value})
      {:ok, %Locale{}}

      iex> update_locale(locale, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_locale(%Locale{} = locale, attrs) do
    locale
    |> Locale.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a locale.

  ## Examples

      iex> delete_locale(locale)
      {:ok, %Locale{}}

      iex> delete_locale(locale)
      {:error, %Ecto.Changeset{}}

  """
  def delete_locale(%Locale{} = locale) do
    Repo.delete(locale)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking locale changes.

  ## Examples

      iex> change_locale(locale)
      %Ecto.Changeset{data: %Locale{}}

  """
  def change_locale(%Locale{} = locale, attrs \\ %{}) do
    Locale.changeset(locale, attrs)
  end

  def update_translate_settings(%TranslateSettings{} = translate_settings, attrs) do
    translate_settings
    |> TranslateSettings.changeset(attrs)
    |> Repo.update()
  end

  alias Jumpstart.Translate.Namespace

  @doc """
  Returns the list of namespaces.

  ## Examples

      iex> list_namespaces()
      [%Namespace{}, ...]

  """
  def list_namespaces do
    Repo.all(Namespace)
  end

  @doc """
  Gets a single namespace.

  Raises `Ecto.NoResultsError` if the Namespace does not exist.

  ## Examples

      iex> get_namespace!(123)
      %Namespace{}

      iex> get_namespace!(456)
      ** (Ecto.NoResultsError)

  """
  def get_namespace!(id), do: Repo.get!(Namespace, id)

  @doc """
  Creates a namespace.

  ## Examples

      iex> create_namespace(%{field: value})
      {:ok, %Namespace{}}

      iex> create_namespace(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_namespace(attrs \\ %{}) do
    %Namespace{}
    |> Namespace.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a namespace.

  ## Examples

      iex> update_namespace(namespace, %{field: new_value})
      {:ok, %Namespace{}}

      iex> update_namespace(namespace, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_namespace(%Namespace{} = namespace, attrs) do
    namespace
    |> Namespace.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a namespace.

  ## Examples

      iex> delete_namespace(namespace)
      {:ok, %Namespace{}}

      iex> delete_namespace(namespace)
      {:error, %Ecto.Changeset{}}

  """
  def delete_namespace(%Namespace{} = namespace) do
    Repo.delete(namespace)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking namespace changes.

  ## Examples

      iex> change_namespace(namespace)
      %Ecto.Changeset{data: %Namespace{}}

  """
  def change_namespace(%Namespace{} = namespace, attrs \\ %{}) do
    Namespace.changeset(namespace, attrs)
  end
end
