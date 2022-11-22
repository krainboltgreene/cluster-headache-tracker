defmodule CoreWeb.ClusterHeadacheEntryLiveTest do
  use CoreWeb.ConnCase

  import Phoenix.LiveViewTest
  import Core.HealthIssuesFixtures

  @create_attrs %{context: "some context"}
  @update_attrs %{context: "some updated context"}
  @invalid_attrs %{context: nil}

  defp create_cluster_headache_entry(_) do
    cluster_headache_entry = cluster_headache_entry_fixture()
    %{cluster_headache_entry: cluster_headache_entry}
  end

  describe "Index" do
    setup [:create_cluster_headache_entry]

    test "lists all cluster_headache_entries", %{
      conn: conn,
      cluster_headache_entry: cluster_headache_entry
    } do
      {:ok, _index_live, html} = live(conn, ~p"/cluster_headache_entries")

      assert html =~ "Listing Cluster headache entries"
      assert html =~ cluster_headache_entry.context
    end

    test "saves new cluster_headache_entry", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headache_entries")

      assert index_live |> element("a", "New Cluster headache entry") |> render_click() =~
               "New Cluster headache entry"

      assert_patch(index_live, ~p"/cluster_headache_entries/new")

      assert index_live
             |> form("#cluster_headache_entry-form", cluster_headache_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cluster_headache_entry-form", cluster_headache_entry: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headache_entries")

      assert html =~ "Cluster headache entry created successfully"
      assert html =~ "some context"
    end

    test "updates cluster_headache_entry in listing", %{
      conn: conn,
      cluster_headache_entry: cluster_headache_entry
    } do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headache_entries")

      assert index_live
             |> element("#cluster_headache_entries-#{cluster_headache_entry.id} a", "Edit")
             |> render_click() =~
               "Edit Cluster headache entry"

      assert_patch(index_live, ~p"/cluster_headache_entries/#{cluster_headache_entry}/edit")

      assert index_live
             |> form("#cluster_headache_entry-form", cluster_headache_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cluster_headache_entry-form", cluster_headache_entry: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headache_entries")

      assert html =~ "Cluster headache entry updated successfully"
      assert html =~ "some updated context"
    end

    test "deletes cluster_headache_entry in listing", %{
      conn: conn,
      cluster_headache_entry: cluster_headache_entry
    } do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headache_entries")

      assert index_live
             |> element("#cluster_headache_entries-#{cluster_headache_entry.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#cluster_headache_entry-#{cluster_headache_entry.id}")
    end
  end

  describe "Show" do
    setup [:create_cluster_headache_entry]

    test "displays cluster_headache_entry", %{
      conn: conn,
      cluster_headache_entry: cluster_headache_entry
    } do
      {:ok, _show_live, html} =
        live(conn, ~p"/cluster_headache_entries/#{cluster_headache_entry}")

      assert html =~ "Show Cluster headache entry"
      assert html =~ cluster_headache_entry.context
    end

    test "updates cluster_headache_entry within modal", %{
      conn: conn,
      cluster_headache_entry: cluster_headache_entry
    } do
      {:ok, show_live, _html} =
        live(conn, ~p"/cluster_headache_entries/#{cluster_headache_entry}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cluster headache entry"

      assert_patch(show_live, ~p"/cluster_headache_entries/#{cluster_headache_entry}/show/edit")

      assert show_live
             |> form("#cluster_headache_entry-form", cluster_headache_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cluster_headache_entry-form", cluster_headache_entry: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headache_entries/#{cluster_headache_entry}")

      assert html =~ "Cluster headache entry updated successfully"
      assert html =~ "some updated context"
    end
  end
end
