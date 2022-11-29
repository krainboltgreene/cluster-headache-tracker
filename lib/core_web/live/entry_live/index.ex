defmodule CoreWeb.EntryLive.Index do
  use CoreWeb, :live_view

  alias Core.HealthIssues
  alias Core.HealthIssues.Entry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :entries, list_entries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    record = HealthIssues.get_entry!(id) |> Core.Repo.preload([:aliment])

    socket
    |> assign(:page_title, "Edit Entry")
    |> assign(:entry, record |> Core.Repo.preload([:aliment]))
    |> assign(:aliments, HealthIssues.list_aliments())
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Entry")
    |> assign(:entry, %Entry{} |> Core.Repo.preload([:aliment]))
    |> assign(:aliments, HealthIssues.list_aliments())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Entries")
    |> assign(:entry, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    entry = HealthIssues.get_entry!(id)
    {:ok, _} = HealthIssues.delete_entry(entry)

    {:noreply, assign(socket, :entries, list_entries())}
  end

  defp list_entries() do
    HealthIssues.list_entries() |> Core.Repo.preload([:aliment])
  end
end
