defmodule CoreWeb.ClusterHeadacheLive.FormComponent do
  use CoreWeb, :live_component

  alias Core.HealthIssues

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form
        :let={_f}
        for={@changeset}
        id="cluster_headache-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <:actions>
          <.button phx-disable-with="Saving...">Save Cluster Headache</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cluster_headache: cluster_headache} = assigns, socket) do
    changeset = HealthIssues.change_cluster_headache(cluster_headache)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"cluster_headache" => cluster_headache_params}, socket) do
    changeset =
      socket.assigns.cluster_headache
      |> HealthIssues.change_cluster_headache(
        cluster_headache_params
        |> Map.put("account", socket.assigns.current_account)
      )
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    changeset =
      socket.assigns.cluster_headache
      |> HealthIssues.change_cluster_headache(%{"account" => socket.assigns.current_account})
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cluster_headache" => cluster_headache_params}, socket) do
    save_cluster_headache(
      socket,
      socket.assigns.action,
      cluster_headache_params |> Map.put("account", socket.assigns.current_account)
    )
  end

  def handle_event("save", _params, socket) do
    save_cluster_headache(socket, socket.assigns.action, %{
      "account" => socket.assigns.current_account
    })
  end

  defp save_cluster_headache(socket, :edit, cluster_headache_params) do
    case HealthIssues.update_cluster_headache(
           socket.assigns.cluster_headache,
           cluster_headache_params
         ) do
      {:ok, _cluster_headache} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster Headache updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cluster_headache(socket, :new, cluster_headache_params) do
    case HealthIssues.create_cluster_headache(cluster_headache_params) do
      {:ok, _cluster_headache} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster Headache created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
