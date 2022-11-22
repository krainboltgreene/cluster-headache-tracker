defmodule CoreWeb.ClusterHeadacheLiveTest do
  use CoreWeb.ConnCase

  import Phoenix.LiveViewTest
  import Core.HealthIssuesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_cluster_headache(_) do
    cluster_headache = cluster_headache_fixture()
    %{cluster_headache: cluster_headache}
  end

  describe "Index" do
    setup [:create_cluster_headache]

    test "lists all cluster_headaches", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/cluster_headaches")

      assert html =~ "Listing Cluster headaches"
    end

    test "saves new cluster_headache", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headaches")

      assert index_live |> element("a", "New Cluster headache") |> render_click() =~
               "New Cluster headache"

      assert_patch(index_live, ~p"/cluster_headaches/new")

      assert index_live
             |> form("#cluster_headache-form", cluster_headache: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cluster_headache-form", cluster_headache: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headaches")

      assert html =~ "Cluster headache created successfully"
    end

    test "updates cluster_headache in listing", %{conn: conn, cluster_headache: cluster_headache} do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headaches")

      assert index_live
             |> element("#cluster_headaches-#{cluster_headache.id} a", "Edit")
             |> render_click() =~
               "Edit Cluster headache"

      assert_patch(index_live, ~p"/cluster_headaches/#{cluster_headache}/edit")

      assert index_live
             |> form("#cluster_headache-form", cluster_headache: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cluster_headache-form", cluster_headache: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headaches")

      assert html =~ "Cluster headache updated successfully"
    end

    test "deletes cluster_headache in listing", %{conn: conn, cluster_headache: cluster_headache} do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headaches")

      assert index_live
             |> element("#cluster_headaches-#{cluster_headache.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#cluster_headache-#{cluster_headache.id}")
    end
  end

  describe "Show" do
    setup [:create_cluster_headache]

    test "displays cluster_headache", %{conn: conn, cluster_headache: cluster_headache} do
      {:ok, _show_live, html} = live(conn, ~p"/cluster_headaches/#{cluster_headache}")

      assert html =~ "Show Cluster headache"
    end

    test "updates cluster_headache within modal", %{
      conn: conn,
      cluster_headache: cluster_headache
    } do
      {:ok, show_live, _html} = live(conn, ~p"/cluster_headaches/#{cluster_headache}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cluster headache"

      assert_patch(show_live, ~p"/cluster_headaches/#{cluster_headache}/show/edit")

      assert show_live
             |> form("#cluster_headache-form", cluster_headache: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cluster_headache-form", cluster_headache: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headaches/#{cluster_headache}")

      assert html =~ "Cluster headache updated successfully"
    end
  end
end
