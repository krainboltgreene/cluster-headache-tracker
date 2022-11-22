defmodule CoreWeb.ClusterHeadacheEntryLive.Index do
  use CoreWeb, :live_view

  alias Core.HealthIssues
  alias Core.HealthIssues.ClusterHeadacheEntry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cluster_headache_entries, list_cluster_headache_entries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cluster headache entry")
    |> assign(:cluster_headache_entry, HealthIssues.get_cluster_headache_entry!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cluster headache entry")
    |> assign(:cluster_headache_entry, %ClusterHeadacheEntry{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cluster headache entries")
    |> assign(:cluster_headache_entry, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cluster_headache_entry = HealthIssues.get_cluster_headache_entry!(id)
    {:ok, _} = HealthIssues.delete_cluster_headache_entry(cluster_headache_entry)

    {:noreply, assign(socket, :cluster_headache_entries, list_cluster_headache_entries())}
  end

  defp list_cluster_headache_entries do
    HealthIssues.list_cluster_headache_entries()
  end
end
