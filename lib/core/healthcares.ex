defmodule Core.Healthcares do
  @moduledoc """
  The Healthcares context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.Healthcares.Medication

  @doc """
  Returns the list of medications.

  ## Examples

      iex> list_medications()
      [%Medication{}, ...]

  """
  def list_medications do
    Repo.all(Medication)
  end

  @doc """
  Gets a single medication.

  Raises `Ecto.NoResultsError` if the Cluster Headache does not exist.

  ## Examples

      iex> get_medication!(123)
      %Medication{}

      iex> get_medication!(456)
      ** (Ecto.NoResultsError)

  """
  def get_medication!(id), do: Repo.get!(Medication, id)

  @doc """
  Creates a medication.

  ## Examples

      iex> create_medication(%{field: value})
      {:ok, %Medication{}}

      iex> create_medication(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_medication(attrs \\ %{}) do
    %Medication{}
    |> Medication.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a medication.

  ## Examples

      iex> update_medication(medication, %{field: new_value})
      {:ok, %Medication{}}

      iex> update_medication(medication, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_medication(%Medication{} = medication, attrs) do
    medication
    |> Medication.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a medication.

  ## Examples

      iex> delete_medication(medication)
      {:ok, %Medication{}}

      iex> delete_medication(medication)
      {:error, %Ecto.Changeset{}}

  """
  def delete_medication(%Medication{} = medication) do
    Repo.delete(medication)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking medication changes.

  ## Examples

      iex> change_medication(medication)
      %Ecto.Changeset{data: %Medication{}}

  """
  def change_medication(%Medication{} = medication, attrs \\ %{}) do
    Medication.changeset(medication, attrs)
  end
end
