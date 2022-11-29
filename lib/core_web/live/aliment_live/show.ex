defmodule CoreWeb.AlimentLive.Show do
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
     |> assign(
       :aliment,
       HealthIssues.get_aliment!(id)
       |> Core.Repo.preload([:entries])
     )}
  end

  defp page_title(:show), do: "Show Aliment"
  defp page_title(:edit), do: "Edit Aliment"
end
