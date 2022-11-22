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

  describe "entries" do
    alias Core.HealthIssues.Entry

    import Core.HealthIssuesFixtures

    @invalid_attrs %{context: nil}

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert HealthIssues.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()

      assert HealthIssues.get_entry!(entry.id) ==
               entry
    end

    test "create_entry/1 with valid data creates a entry" do
      valid_attrs = %{context: "some context"}

      assert {:ok, %Entry{} = entry} = HealthIssues.create_entry(valid_attrs)

      assert entry.context == "some context"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HealthIssues.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      update_attrs = %{context: "some updated context"}

      assert {:ok, %Entry{} = entry} = HealthIssues.update_entry(entry, update_attrs)

      assert entry.context == "some updated context"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()

      assert {:error, %Ecto.Changeset{}} = HealthIssues.update_entry(entry, @invalid_attrs)

      assert entry ==
               HealthIssues.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()

      assert {:ok, %Entry{}} = HealthIssues.delete_entry(entry)

      assert_raise Ecto.NoResultsError, fn ->
        HealthIssues.get_entry!(entry.id)
      end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()

      assert %Ecto.Changeset{} = HealthIssues.change_entry(entry)
    end
  end
end
