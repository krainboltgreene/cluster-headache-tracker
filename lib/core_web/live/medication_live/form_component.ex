defmodule CoreWeb.MedicationLive.FormComponent do
  use CoreWeb, :live_component

  alias Core.Healthcares

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
        id="medication-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :name}} type="text" label="Name" />
        <.input field={{f, :dosage}} type="text" label="Dosage" />
        <.input field={{f, :cooldown}} type="number" label="Cooldown (Hours)" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Medication</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{medication: medication} = assigns, socket) do
    changeset = Healthcares.change_medication(medication)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"medication" => medication_params}, socket) do
    changeset =
      socket.assigns.medication
      |> Healthcares.change_medication(
        medication_params
      )
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate", params, socket) do
    changeset =
      socket.assigns.medication
      |> Healthcares.change_medication(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"medication" => medication_params}, socket) do
    save_medication(
      socket,
      socket.assigns.action,
      medication_params
    )
  end

  @impl true
  def handle_event("save", params, socket) do
    save_medication(socket, socket.assigns.action, params)
  end

  defp save_medication(socket, :edit, medication_params) do
    case Healthcares.update_medication(
           socket.assigns.medication,
           medication_params
         ) do
      {:ok, _medication} ->
        {:noreply,
         socket
         |> put_flash(:info, "Medication updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_medication(socket, :new, medication_params) do
    case Healthcares.create_medication(medication_params) do
      {:ok, _medication} ->
        {:noreply,
         socket
         |> put_flash(:info, "Medication created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
