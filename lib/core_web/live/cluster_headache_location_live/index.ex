defmodule CoreWeb.ClusterHeadacheLocationLive.Index do
  use CoreWeb, :live_view

  alias Core.HealthIssues
  alias Core.HealthIssues.ClusterHeadacheLocation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cluster_headache_locations, list_cluster_headache_locations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cluster headache location")
    |> assign(:cluster_headache_location, HealthIssues.get_cluster_headache_location!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cluster headache location")
    |> assign(:cluster_headache_location, %ClusterHeadacheLocation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cluster headache locations")
    |> assign(:cluster_headache_location, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cluster_headache_location = HealthIssues.get_cluster_headache_location!(id)
    {:ok, _} = HealthIssues.delete_cluster_headache_location(cluster_headache_location)

    {:noreply, assign(socket, :cluster_headache_locations, list_cluster_headache_locations())}
  end

  defp list_cluster_headache_locations do
    HealthIssues.list_cluster_headache_locations()
  end
end
