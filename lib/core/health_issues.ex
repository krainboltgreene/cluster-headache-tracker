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

  alias Core.HealthIssues.Entry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries(cluster_headache_id) do
    from(
      entry in Entry,
      where: entry.cluster_headache_id == ^cluster_headache_id
    )
    |> Repo.all()
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Cluster headache entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{data: %Entry{}}

  """
  def change_entry(
        %Entry{} = entry,
        attrs \\ %{}
      ) do
    Entry.changeset(entry, attrs)
  end
end
