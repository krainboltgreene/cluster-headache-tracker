defmodule Core.HealthIssuesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Core.HealthIssues` context.
  """

  @doc """
  Generate a cluster_headache.
  """
  def cluster_headache_fixture(attrs \\ %{}) do
    {:ok, cluster_headache} =
      attrs
      |> Enum.into(%{})
      |> Core.HealthIssues.create_cluster_headache()

    cluster_headache
  end

  @doc """
  Generate a cluster_headache_entry.
  """
  def cluster_headache_entry_fixture(attrs \\ %{}) do
    {:ok, cluster_headache_entry} =
      attrs
      |> Enum.into(%{
        context: "some context"
      })
      |> Core.HealthIssues.create_cluster_headache_entry()

    cluster_headache_entry
  end

  @doc """
  Generate a cluster_headache_location.
  """
  def cluster_headache_location_fixture(attrs \\ %{}) do
    {:ok, cluster_headache_location} =
      attrs
      |> Enum.into(%{
        intensity: 42,
        radius: 42,
        x: 42,
        y: 42
      })
      |> Core.HealthIssues.create_cluster_headache_location()

    cluster_headache_location
  end
end
