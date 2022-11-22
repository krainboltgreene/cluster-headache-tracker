defmodule CoreWeb.ClusterHeadacheLocationLiveTest do
  use CoreWeb.ConnCase

  import Phoenix.LiveViewTest
  import Core.HealthIssuesFixtures

  @create_attrs %{intensity: 42, radius: 42, x: 42, y: 42}
  @update_attrs %{intensity: 43, radius: 43, x: 43, y: 43}
  @invalid_attrs %{intensity: nil, radius: nil, x: nil, y: nil}

  defp create_cluster_headache_location(_) do
    cluster_headache_location = cluster_headache_location_fixture()
    %{cluster_headache_location: cluster_headache_location}
  end

  describe "Index" do
    setup [:create_cluster_headache_location]

    test "lists all cluster_headache_locations", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/cluster_headache_locations")

      assert html =~ "Listing Cluster headache locations"
    end

    test "saves new cluster_headache_location", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headache_locations")

      assert index_live |> element("a", "New Cluster headache location") |> render_click() =~
               "New Cluster headache location"

      assert_patch(index_live, ~p"/cluster_headache_locations/new")

      assert index_live
             |> form("#cluster_headache_location-form", cluster_headache_location: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cluster_headache_location-form", cluster_headache_location: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headache_locations")

      assert html =~ "Cluster headache location created successfully"
    end

    test "updates cluster_headache_location in listing", %{
      conn: conn,
      cluster_headache_location: cluster_headache_location
    } do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headache_locations")

      assert index_live
             |> element("#cluster_headache_locations-#{cluster_headache_location.id} a", "Edit")
             |> render_click() =~
               "Edit Cluster headache location"

      assert_patch(index_live, ~p"/cluster_headache_locations/#{cluster_headache_location}/edit")

      assert index_live
             |> form("#cluster_headache_location-form", cluster_headache_location: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cluster_headache_location-form", cluster_headache_location: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headache_locations")

      assert html =~ "Cluster headache location updated successfully"
    end

    test "deletes cluster_headache_location in listing", %{
      conn: conn,
      cluster_headache_location: cluster_headache_location
    } do
      {:ok, index_live, _html} = live(conn, ~p"/cluster_headache_locations")

      assert index_live
             |> element("#cluster_headache_locations-#{cluster_headache_location.id} a", "Delete")
             |> render_click()

      refute has_element?(
               index_live,
               "#cluster_headache_location-#{cluster_headache_location.id}"
             )
    end
  end

  describe "Show" do
    setup [:create_cluster_headache_location]

    test "displays cluster_headache_location", %{
      conn: conn,
      cluster_headache_location: cluster_headache_location
    } do
      {:ok, _show_live, html} =
        live(conn, ~p"/cluster_headache_locations/#{cluster_headache_location}")

      assert html =~ "Show Cluster headache location"
    end

    test "updates cluster_headache_location within modal", %{
      conn: conn,
      cluster_headache_location: cluster_headache_location
    } do
      {:ok, show_live, _html} =
        live(conn, ~p"/cluster_headache_locations/#{cluster_headache_location}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cluster headache location"

      assert_patch(
        show_live,
        ~p"/cluster_headache_locations/#{cluster_headache_location}/show/edit"
      )

      assert show_live
             |> form("#cluster_headache_location-form", cluster_headache_location: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cluster_headache_location-form", cluster_headache_location: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/cluster_headache_locations/#{cluster_headache_location}")

      assert html =~ "Cluster headache location updated successfully"
    end
  end
end
