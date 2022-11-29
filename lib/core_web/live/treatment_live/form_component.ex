defmodule CoreWeb.TreatmentLive.FormComponent do
  use CoreWeb, :live_component

  alias Core.HealthIssues

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          Use this form to manage treatment records in your database.
        </:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="treatment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={{f, :medication_id}}
          type="select"
          label="Medication"
          prompt="Select a medication"
          options={@medications |> Enum.map(&{"#{&1.name} (#{&1.dosage})", &1.id})}
        />
        <.input field={{f, :dosage}} type="text" label="Dosage" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Treatment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{treatment: treatment} = assigns, socket) do
    changeset = HealthIssues.change_treatment(treatment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event(
        "validate",
        %{"treatment" => treatment_params},
        socket
      ) do
    changeset =
      socket.assigns.treatment
      |> HealthIssues.change_treatment(treatment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"treatment" => treatment_params}, socket) do
    save_treatment(
      socket,
      socket.assigns.action,
      treatment_params
    )
  end

  defp save_treatment(socket, :edit, treatment_params) do
    case HealthIssues.update_treatment(
           socket.assigns.treatment,
           treatment_params
         ) do
      {:ok, _treatment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Treatment updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_treatment(socket, :new, treatment_params) do
    case HealthIssues.create_treatment(treatment_params) do
      {:ok, _treatment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Treatment created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
