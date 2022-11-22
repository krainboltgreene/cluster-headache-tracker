defmodule CoreWeb.EntryLive.Index do
  use CoreWeb, :live_view

  alias Core.HealthIssues
  alias Core.HealthIssues.Entry

  @impl true
  def mount(%{"cluster_headache_id" => cluster_headache_id}, _session, socket) do
    {:ok, assign(socket, :entries, list_entries(cluster_headache_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cluster headache entry")
    |> assign(:entry, HealthIssues.get_entry!(id))
  end

  defp apply_action(socket, :new, %{"cluster_headache_id" => cluster_headache_id}) do
    socket
    |> assign(:page_title, "New Cluster headache entry")
    |> assign(:entry, %Entry{})
    |> assign(:cluster_headache, HealthIssues.get_cluster_headache!(cluster_headache_id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cluster headache entries")
    |> assign(:entry, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id, "cluster_headache_id" => cluster_headache_id}, socket) do
    entry = HealthIssues.get_entry!(id)
    {:ok, _} = HealthIssues.delete_entry(entry)

    {:noreply, assign(socket, :entries, list_entries(cluster_headache_id))}
  end

  defp list_entries(cluster_headache_id) do
    HealthIssues.list_entries(cluster_headache_id)
  end
end