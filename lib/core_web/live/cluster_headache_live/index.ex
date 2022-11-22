defmodule CoreWeb.ClusterHeadacheLive.Index do
  use CoreWeb, :live_view

  alias Core.HealthIssues
  alias Core.HealthIssues.ClusterHeadache

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cluster_headaches, list_cluster_headaches())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cluster headache")
    |> assign(:cluster_headache, HealthIssues.get_cluster_headache!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cluster headache")
    |> assign(:cluster_headache, %ClusterHeadache{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cluster headaches")
    |> assign(:cluster_headache, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cluster_headache = HealthIssues.get_cluster_headache!(id)
    {:ok, _} = HealthIssues.delete_cluster_headache(cluster_headache)

    {:noreply, assign(socket, :cluster_headaches, list_cluster_headaches())}
  end

  defp list_cluster_headaches do
    HealthIssues.list_cluster_headaches()
  end
end
