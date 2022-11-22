defmodule CoreWeb.ClusterHeadacheEntryLive.FormComponent do
  use CoreWeb, :live_component

  alias Core.HealthIssues

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          Use this form to manage cluster_headache_entry records in your database.
        </:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="cluster_headache_entry-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :context}} type="text" label="context" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cluster headache entry</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cluster_headache_entry: cluster_headache_entry} = assigns, socket) do
    changeset = HealthIssues.change_cluster_headache_entry(cluster_headache_entry)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event(
        "validate",
        %{"cluster_headache_entry" => cluster_headache_entry_params},
        socket
      ) do
    changeset =
      socket.assigns.cluster_headache_entry
      |> HealthIssues.change_cluster_headache_entry(cluster_headache_entry_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cluster_headache_entry" => cluster_headache_entry_params}, socket) do
    save_cluster_headache_entry(socket, socket.assigns.action, cluster_headache_entry_params)
  end

  defp save_cluster_headache_entry(socket, :edit, cluster_headache_entry_params) do
    case HealthIssues.update_cluster_headache_entry(
           socket.assigns.cluster_headache_entry,
           cluster_headache_entry_params
         ) do
      {:ok, _cluster_headache_entry} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster headache entry updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cluster_headache_entry(socket, :new, cluster_headache_entry_params) do
    case HealthIssues.create_cluster_headache_entry(cluster_headache_entry_params) do
      {:ok, _cluster_headache_entry} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster headache entry created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
