defmodule CoreWeb.ClusterHeadacheLocationLive.FormComponent do
  use CoreWeb, :live_component

  alias Core.HealthIssues

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          Use this form to manage cluster_headache_location records in your database.
        </:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="cluster_headache_location-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :x}} type="number" label="x" />
        <.input field={{f, :y}} type="number" label="y" />
        <.input field={{f, :intensity}} type="number" label="intensity" />
        <.input field={{f, :radius}} type="number" label="radius" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cluster headache location</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cluster_headache_location: cluster_headache_location} = assigns, socket) do
    changeset = HealthIssues.change_cluster_headache_location(cluster_headache_location)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event(
        "validate",
        %{"cluster_headache_location" => cluster_headache_location_params},
        socket
      ) do
    changeset =
      socket.assigns.cluster_headache_location
      |> HealthIssues.change_cluster_headache_location(cluster_headache_location_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event(
        "save",
        %{"cluster_headache_location" => cluster_headache_location_params},
        socket
      ) do
    save_cluster_headache_location(
      socket,
      socket.assigns.action,
      cluster_headache_location_params
    )
  end

  defp save_cluster_headache_location(socket, :edit, cluster_headache_location_params) do
    case HealthIssues.update_cluster_headache_location(
           socket.assigns.cluster_headache_location,
           cluster_headache_location_params
         ) do
      {:ok, _cluster_headache_location} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster headache location updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cluster_headache_location(socket, :new, cluster_headache_location_params) do
    case HealthIssues.create_cluster_headache_location(cluster_headache_location_params) do
      {:ok, _cluster_headache_location} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster headache location created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
