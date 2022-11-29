defmodule CoreWeb.TreatmentLive.Index do
  use CoreWeb, :live_view

  alias Core.HealthIssues
  alias Core.HealthIssues.Treatment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :treatments, list_treatments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Treatment")
    |> assign(
      :treatment,
      HealthIssues.get_treatment!(id) |> Core.Repo.preload([:medication])
    )
    |> assign(:medications, Core.Healthcares.list_medications())
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Treatment")
    |> assign(:treatment, %Treatment{} |> Core.Repo.preload([:medication]))
    |> assign(:medications, Core.Healthcares.list_medications())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Treatments")
    |> assign(:treatment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    treatment = HealthIssues.get_treatment!(id)
    {:ok, _} = HealthIssues.delete_treatment(treatment)

    {:noreply, assign(socket, :treatments, list_treatments())}
  end

  defp list_treatments() do
    HealthIssues.list_treatments()
    |> Core.Repo.preload([:medication])
  end
end
