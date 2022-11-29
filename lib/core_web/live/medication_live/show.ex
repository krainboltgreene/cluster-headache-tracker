defmodule CoreWeb.MedicationLive.Show do
  use CoreWeb, :live_view

  alias Core.Healthcares

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
       :medication,
       Healthcares.get_medication!(id)
       |> Core.Repo.preload([:treatments])
     )}
  end

  defp page_title(:show), do: "Show Medication"
  defp page_title(:edit), do: "Edit Medication"
end
