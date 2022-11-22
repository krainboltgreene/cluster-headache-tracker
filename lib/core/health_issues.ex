defmodule Core.HealthIssues do
  @moduledoc """
  The HealthIssues context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.HealthIssues.ClusterHeadache

  @doc """
  Returns the list of cluster_headaches.

  ## Examples

      iex> list_cluster_headaches()
      [%ClusterHeadache{}, ...]

  """
  def list_cluster_headaches do
    Repo.all(ClusterHeadache)
  end

  @doc """
  Gets a single cluster_headache.

  Raises `Ecto.NoResultsError` if the Cluster headache does not exist.

  ## Examples

      iex> get_cluster_headache!(123)
      %ClusterHeadache{}

      iex> get_cluster_headache!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cluster_headache!(id), do: Repo.get!(ClusterHeadache, id)

  @doc """
  Creates a cluster_headache.

  ## Examples

      iex> create_cluster_headache(%{field: value})
      {:ok, %ClusterHeadache{}}

      iex> create_cluster_headache(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cluster_headache(attrs \\ %{}) do
    %ClusterHeadache{}
    |> ClusterHeadache.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cluster_headache.

  ## Examples

      iex> update_cluster_headache(cluster_headache, %{field: new_value})
      {:ok, %ClusterHeadache{}}

      iex> update_cluster_headache(cluster_headache, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cluster_headache(%ClusterHeadache{} = cluster_headache, attrs) do
    cluster_headache
    |> ClusterHeadache.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cluster_headache.

  ## Examples

      iex> delete_cluster_headache(cluster_headache)
      {:ok, %ClusterHeadache{}}

      iex> delete_cluster_headache(cluster_headache)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cluster_headache(%ClusterHeadache{} = cluster_headache) do
    Repo.delete(cluster_headache)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cluster_headache changes.

  ## Examples

      iex> change_cluster_headache(cluster_headache)
      %Ecto.Changeset{data: %ClusterHeadache{}}

  """
  def change_cluster_headache(%ClusterHeadache{} = cluster_headache, attrs \\ %{}) do
    ClusterHeadache.changeset(cluster_headache, attrs)
  end

  alias Core.HealthIssues.ClusterHeadacheEntry

  @doc """
  Returns the list of cluster_headache_entries.

  ## Examples

      iex> list_cluster_headache_entries()
      [%ClusterHeadacheEntry{}, ...]

  """
  def list_cluster_headache_entries do
    Repo.all(ClusterHeadacheEntry)
  end

  @doc """
  Gets a single cluster_headache_entry.

  Raises `Ecto.NoResultsError` if the Cluster headache entry does not exist.

  ## Examples

      iex> get_cluster_headache_entry!(123)
      %ClusterHeadacheEntry{}

      iex> get_cluster_headache_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cluster_headache_entry!(id), do: Repo.get!(ClusterHeadacheEntry, id)

  @doc """
  Creates a cluster_headache_entry.

  ## Examples

      iex> create_cluster_headache_entry(%{field: value})
      {:ok, %ClusterHeadacheEntry{}}

      iex> create_cluster_headache_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cluster_headache_entry(attrs \\ %{}) do
    %ClusterHeadacheEntry{}
    |> ClusterHeadacheEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cluster_headache_entry.

  ## Examples

      iex> update_cluster_headache_entry(cluster_headache_entry, %{field: new_value})
      {:ok, %ClusterHeadacheEntry{}}

      iex> update_cluster_headache_entry(cluster_headache_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cluster_headache_entry(%ClusterHeadacheEntry{} = cluster_headache_entry, attrs) do
    cluster_headache_entry
    |> ClusterHeadacheEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cluster_headache_entry.

  ## Examples

      iex> delete_cluster_headache_entry(cluster_headache_entry)
      {:ok, %ClusterHeadacheEntry{}}

      iex> delete_cluster_headache_entry(cluster_headache_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cluster_headache_entry(%ClusterHeadacheEntry{} = cluster_headache_entry) do
    Repo.delete(cluster_headache_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cluster_headache_entry changes.

  ## Examples

      iex> change_cluster_headache_entry(cluster_headache_entry)
      %Ecto.Changeset{data: %ClusterHeadacheEntry{}}

  """
  def change_cluster_headache_entry(
        %ClusterHeadacheEntry{} = cluster_headache_entry,
        attrs \\ %{}
      ) do
    ClusterHeadacheEntry.changeset(cluster_headache_entry, attrs)
  end

  alias Core.HealthIssues.ClusterHeadacheLocation

  @doc """
  Returns the list of cluster_headache_locations.

  ## Examples

      iex> list_cluster_headache_locations()
      [%ClusterHeadacheLocation{}, ...]

  """
  def list_cluster_headache_locations do
    Repo.all(ClusterHeadacheLocation)
  end

  @doc """
  Gets a single cluster_headache_location.

  Raises `Ecto.NoResultsError` if the Cluster headache location does not exist.

  ## Examples

      iex> get_cluster_headache_location!(123)
      %ClusterHeadacheLocation{}

      iex> get_cluster_headache_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cluster_headache_location!(id), do: Repo.get!(ClusterHeadacheLocation, id)

  @doc """
  Creates a cluster_headache_location.

  ## Examples

      iex> create_cluster_headache_location(%{field: value})
      {:ok, %ClusterHeadacheLocation{}}

      iex> create_cluster_headache_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cluster_headache_location(attrs \\ %{}) do
    %ClusterHeadacheLocation{}
    |> ClusterHeadacheLocation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cluster_headache_location.

  ## Examples

      iex> update_cluster_headache_location(cluster_headache_location, %{field: new_value})
      {:ok, %ClusterHeadacheLocation{}}

      iex> update_cluster_headache_location(cluster_headache_location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cluster_headache_location(
        %ClusterHeadacheLocation{} = cluster_headache_location,
        attrs
      ) do
    cluster_headache_location
    |> ClusterHeadacheLocation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cluster_headache_location.

  ## Examples

      iex> delete_cluster_headache_location(cluster_headache_location)
      {:ok, %ClusterHeadacheLocation{}}

      iex> delete_cluster_headache_location(cluster_headache_location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cluster_headache_location(%ClusterHeadacheLocation{} = cluster_headache_location) do
    Repo.delete(cluster_headache_location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cluster_headache_location changes.

  ## Examples

      iex> change_cluster_headache_location(cluster_headache_location)
      %Ecto.Changeset{data: %ClusterHeadacheLocation{}}

  """
  def change_cluster_headache_location(
        %ClusterHeadacheLocation{} = cluster_headache_location,
        attrs \\ %{}
      ) do
    ClusterHeadacheLocation.changeset(cluster_headache_location, attrs)
  end
end
