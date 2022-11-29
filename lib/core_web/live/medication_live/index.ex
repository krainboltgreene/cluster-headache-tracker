defmodule CoreWeb.MedicationLive.Index do
  use CoreWeb, :live_view

  alias Core.Healthcares
  alias Core.Healthcares.Medication

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :medications, list_medications())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Medication")
    |> assign(
      :medication,
      Healthcares.get_medication!(id)
      |> Core.Repo.preload([:treatments])
    )
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Medication")
    |> assign(:medication, %Medication{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Medications")
    |> assign(:medication, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    medication = Healthcares.get_medication!(id)
    {:ok, _} = Healthcares.delete_medication(medication)

    {:noreply, assign(socket, :medications, list_medications())}
  end

  defp list_medications do
    Healthcares.list_medications()
    |> Core.Repo.preload([:treatments])
  end
end
