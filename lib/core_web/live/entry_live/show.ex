defmodule CoreWeb.EntryLive.Show do
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
     |> assign(:entry, HealthIssues.get_entry!(id))}
  end

  defp page_title(:show), do: "Show Cluster headache entry"
  defp page_title(:edit), do: "Edit Cluster headache entry"
end
