defmodule Core.HealthIssues do
  @moduledoc """
  The HealthIssues context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.HealthIssues.Aliment

  @doc """
  Returns the list of aliments.

  ## Examples

      iex> list_aliments()
      [%Aliment{}, ...]

  """
  def list_aliments do
    from(
      aliment in Aliment,
      order_by: [desc: :inserted_at]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single aliment.

  Raises `Ecto.NoResultsError` if the Cluster Headache does not exist.

  ## Examples

      iex> get_aliment!(123)
      %Aliment{}

      iex> get_aliment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_aliment!(id), do: Repo.get!(Aliment, id)

  @doc """
  Creates a aliment.

  ## Examples

      iex> create_aliment(%{field: value})
      {:ok, %Aliment{}}

      iex> create_aliment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_aliment(attrs \\ %{}) do
    %Aliment{}
    |> Aliment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a aliment.

  ## Examples

      iex> update_aliment(aliment, %{field: new_value})
      {:ok, %Aliment{}}

      iex> update_aliment(aliment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_aliment(%Aliment{} = aliment, attrs) do
    aliment
    |> Aliment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a aliment.

  ## Examples

      iex> delete_aliment(aliment)
      {:ok, %Aliment{}}

      iex> delete_aliment(aliment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_aliment(%Aliment{} = aliment) do
    Repo.delete(aliment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking aliment changes.

  ## Examples

      iex> change_aliment(aliment)
      %Ecto.Changeset{data: %Aliment{}}

  """
  def change_aliment(%Aliment{} = aliment, attrs \\ %{}) do
    Aliment.changeset(aliment, attrs)
  end

  alias Core.HealthIssues.Entry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries() do
    Repo.all(Entry)
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

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

  alias Core.HealthIssues.Treatment

  @doc """
  Returns the list of treatments.

  ## Examples

      iex> list_treatments()
      [%Treatment{}, ...]

  """
  def list_treatments() do
    Repo.all(Treatment)
  end

  @doc """
  Gets a single treatment.

  Raises `Ecto.NoResultsError` if the Treatment does not exist.

  ## Examples

      iex> get_treatment!(123)
      %Treatment{}

      iex> get_treatment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_treatment!(id), do: Repo.get!(Treatment, id)

  @doc """
  Creates a treatment.

  ## Examples

      iex> create_treatment(%{field: value})
      {:ok, %Treatment{}}

      iex> create_treatment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_treatment(attrs \\ %{}) do
    %Treatment{}
    |> Treatment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a treatment.

  ## Examples

      iex> update_treatment(treatment, %{field: new_value})
      {:ok, %Treatment{}}

      iex> update_treatment(treatment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_treatment(%Treatment{} = treatment, attrs) do
    treatment
    |> Treatment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a treatment.

  ## Examples

      iex> delete_treatment(treatment)
      {:ok, %Treatment{}}

      iex> delete_treatment(treatment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_treatment(%Treatment{} = treatment) do
    Repo.delete(treatment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking treatment changes.

  ## Examples

      iex> change_treatment(treatment)
      %Ecto.Changeset{data: %Treatment{}}

  """
  def change_treatment(
        %Treatment{} = treatment,
        attrs \\ %{}
      ) do
    Treatment.changeset(treatment, attrs)
  end
end
