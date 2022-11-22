defmodule Core.HealthIssuesTest do
  use Core.DataCase

  alias Core.HealthIssues

  describe "cluster_headaches" do
    alias Core.HealthIssues.ClusterHeadache

    import Core.HealthIssuesFixtures

    @invalid_attrs %{}

    test "list_cluster_headaches/0 returns all cluster_headaches" do
      cluster_headache = cluster_headache_fixture()
      assert HealthIssues.list_cluster_headaches() == [cluster_headache]
    end

    test "get_cluster_headache!/1 returns the cluster_headache with given id" do
      cluster_headache = cluster_headache_fixture()
      assert HealthIssues.get_cluster_headache!(cluster_headache.id) == cluster_headache
    end

    test "create_cluster_headache/1 with valid data creates a cluster_headache" do
      valid_attrs = %{}

      assert {:ok, %ClusterHeadache{} = cluster_headache} =
               HealthIssues.create_cluster_headache(valid_attrs)
    end

    test "create_cluster_headache/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HealthIssues.create_cluster_headache(@invalid_attrs)
    end

    test "update_cluster_headache/2 with valid data updates the cluster_headache" do
      cluster_headache = cluster_headache_fixture()
      update_attrs = %{}

      assert {:ok, %ClusterHeadache{} = cluster_headache} =
               HealthIssues.update_cluster_headache(cluster_headache, update_attrs)
    end

    test "update_cluster_headache/2 with invalid data returns error changeset" do
      cluster_headache = cluster_headache_fixture()

      assert {:error, %Ecto.Changeset{}} =
               HealthIssues.update_cluster_headache(cluster_headache, @invalid_attrs)

      assert cluster_headache == HealthIssues.get_cluster_headache!(cluster_headache.id)
    end

    test "delete_cluster_headache/1 deletes the cluster_headache" do
      cluster_headache = cluster_headache_fixture()
      assert {:ok, %ClusterHeadache{}} = HealthIssues.delete_cluster_headache(cluster_headache)

      assert_raise Ecto.NoResultsError, fn ->
        HealthIssues.get_cluster_headache!(cluster_headache.id)
      end
    end

    test "change_cluster_headache/1 returns a cluster_headache changeset" do
      cluster_headache = cluster_headache_fixture()
      assert %Ecto.Changeset{} = HealthIssues.change_cluster_headache(cluster_headache)
    end
  end

  describe "cluster_headache_entries" do
    alias Core.HealthIssues.ClusterHeadacheEntry

    import Core.HealthIssuesFixtures

    @invalid_attrs %{context: nil}

    test "list_cluster_headache_entries/0 returns all cluster_headache_entries" do
      cluster_headache_entry = cluster_headache_entry_fixture()
      assert HealthIssues.list_cluster_headache_entries() == [cluster_headache_entry]
    end

    test "get_cluster_headache_entry!/1 returns the cluster_headache_entry with given id" do
      cluster_headache_entry = cluster_headache_entry_fixture()

      assert HealthIssues.get_cluster_headache_entry!(cluster_headache_entry.id) ==
               cluster_headache_entry
    end

    test "create_cluster_headache_entry/1 with valid data creates a cluster_headache_entry" do
      valid_attrs = %{context: "some context"}

      assert {:ok, %ClusterHeadacheEntry{} = cluster_headache_entry} =
               HealthIssues.create_cluster_headache_entry(valid_attrs)

      assert cluster_headache_entry.context == "some context"
    end

    test "create_cluster_headache_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               HealthIssues.create_cluster_headache_entry(@invalid_attrs)
    end

    test "update_cluster_headache_entry/2 with valid data updates the cluster_headache_entry" do
      cluster_headache_entry = cluster_headache_entry_fixture()
      update_attrs = %{context: "some updated context"}

      assert {:ok, %ClusterHeadacheEntry{} = cluster_headache_entry} =
               HealthIssues.update_cluster_headache_entry(cluster_headache_entry, update_attrs)

      assert cluster_headache_entry.context == "some updated context"
    end

    test "update_cluster_headache_entry/2 with invalid data returns error changeset" do
      cluster_headache_entry = cluster_headache_entry_fixture()

      assert {:error, %Ecto.Changeset{}} =
               HealthIssues.update_cluster_headache_entry(cluster_headache_entry, @invalid_attrs)

      assert cluster_headache_entry ==
               HealthIssues.get_cluster_headache_entry!(cluster_headache_entry.id)
    end

    test "delete_cluster_headache_entry/1 deletes the cluster_headache_entry" do
      cluster_headache_entry = cluster_headache_entry_fixture()

      assert {:ok, %ClusterHeadacheEntry{}} =
               HealthIssues.delete_cluster_headache_entry(cluster_headache_entry)

      assert_raise Ecto.NoResultsError, fn ->
        HealthIssues.get_cluster_headache_entry!(cluster_headache_entry.id)
      end
    end

    test "change_cluster_headache_entry/1 returns a cluster_headache_entry changeset" do
      cluster_headache_entry = cluster_headache_entry_fixture()

      assert %Ecto.Changeset{} =
               HealthIssues.change_cluster_headache_entry(cluster_headache_entry)
    end
  end

  describe "cluster_headache_locations" do
    alias Core.HealthIssues.ClusterHeadacheLocation

    import Core.HealthIssuesFixtures

    @invalid_attrs %{intensity: nil, radius: nil, x: nil, y: nil}

    test "list_cluster_headache_locations/0 returns all cluster_headache_locations" do
      cluster_headache_location = cluster_headache_location_fixture()
      assert HealthIssues.list_cluster_headache_locations() == [cluster_headache_location]
    end

    test "get_cluster_headache_location!/1 returns the cluster_headache_location with given id" do
      cluster_headache_location = cluster_headache_location_fixture()

      assert HealthIssues.get_cluster_headache_location!(cluster_headache_location.id) ==
               cluster_headache_location
    end

    test "create_cluster_headache_location/1 with valid data creates a cluster_headache_location" do
      valid_attrs = %{intensity: 42, radius: 42, x: 42, y: 42}

      assert {:ok, %ClusterHeadacheLocation{} = cluster_headache_location} =
               HealthIssues.create_cluster_headache_location(valid_attrs)

      assert cluster_headache_location.intensity == 42
      assert cluster_headache_location.radius == 42
      assert cluster_headache_location.x == 42
      assert cluster_headache_location.y == 42
    end

    test "create_cluster_headache_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               HealthIssues.create_cluster_headache_location(@invalid_attrs)
    end

    test "update_cluster_headache_location/2 with valid data updates the cluster_headache_location" do
      cluster_headache_location = cluster_headache_location_fixture()
      update_attrs = %{intensity: 43, radius: 43, x: 43, y: 43}

      assert {:ok, %ClusterHeadacheLocation{} = cluster_headache_location} =
               HealthIssues.update_cluster_headache_location(
                 cluster_headache_location,
                 update_attrs
               )

      assert cluster_headache_location.intensity == 43
      assert cluster_headache_location.radius == 43
      assert cluster_headache_location.x == 43
      assert cluster_headache_location.y == 43
    end

    test "update_cluster_headache_location/2 with invalid data returns error changeset" do
      cluster_headache_location = cluster_headache_location_fixture()

      assert {:error, %Ecto.Changeset{}} =
               HealthIssues.update_cluster_headache_location(
                 cluster_headache_location,
                 @invalid_attrs
               )

      assert cluster_headache_location ==
               HealthIssues.get_cluster_headache_location!(cluster_headache_location.id)
    end

    test "delete_cluster_headache_location/1 deletes the cluster_headache_location" do
      cluster_headache_location = cluster_headache_location_fixture()

      assert {:ok, %ClusterHeadacheLocation{}} =
               HealthIssues.delete_cluster_headache_location(cluster_headache_location)

      assert_raise Ecto.NoResultsError, fn ->
        HealthIssues.get_cluster_headache_location!(cluster_headache_location.id)
      end
    end

    test "change_cluster_headache_location/1 returns a cluster_headache_location changeset" do
      cluster_headache_location = cluster_headache_location_fixture()

      assert %Ecto.Changeset{} =
               HealthIssues.change_cluster_headache_location(cluster_headache_location)
    end
  end
end
