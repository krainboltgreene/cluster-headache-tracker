defmodule CoreWeb.ClusterHeadacheLive.Show do
  use CoreWeb, :live_view

  alias Core.HealthIssues

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cluster_headache, HealthIssues.get_cluster_headache!(id))}
  end

  defp page_title(:show), do: "Show Cluster headache"
  defp page_title(:edit), do: "Edit Cluster headache"
end
