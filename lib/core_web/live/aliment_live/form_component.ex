defmodule CoreWeb.AlimentLive.FormComponent do
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
        :let={f}
        for={@changeset}
        id="aliment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :name}} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Aliment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{aliment: aliment} = assigns, socket) do
    changeset = HealthIssues.change_aliment(aliment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"aliment" => aliment_params}, socket) do
    changeset =
      socket.assigns.aliment
      |> HealthIssues.change_aliment(
        aliment_params
      )
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate", params, socket) do
    changeset =
      socket.assigns.aliment
      |> HealthIssues.change_aliment(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"aliment" => aliment_params}, socket) do
    save_aliment(
      socket,
      socket.assigns.action,
      aliment_params
    )
  end

  @impl true
  def handle_event("save", params, socket) do
    save_aliment(socket, socket.assigns.action, params)
  end

  defp save_aliment(socket, :edit, aliment_params) do
    case HealthIssues.update_aliment(
           socket.assigns.aliment,
           aliment_params
         ) do
      {:ok, _aliment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Aliment updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_aliment(socket, :new, aliment_params) do
    case HealthIssues.create_aliment(aliment_params) do
      {:ok, _aliment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Aliment created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
