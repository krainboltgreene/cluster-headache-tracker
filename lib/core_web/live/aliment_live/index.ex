defmodule CoreWeb.AlimentLive.Index do
  use CoreWeb, :live_view

  alias Core.HealthIssues
  alias Core.HealthIssues.Aliment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :aliments, list_aliments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Aliment")
    |> assign(
      :aliment,
      HealthIssues.get_aliment!(id)
      |> Core.Repo.preload([:entries])
    )
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Aliment")
    |> assign(:aliment, %Aliment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Aliments")
    |> assign(:aliment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    aliment = HealthIssues.get_aliment!(id)
    {:ok, _} = HealthIssues.delete_aliment(aliment)

    {:noreply, assign(socket, :aliments, list_aliments())}
  end

  defp list_aliments do
    HealthIssues.list_aliments()
    |> Core.Repo.preload([:entries])
  end
end
