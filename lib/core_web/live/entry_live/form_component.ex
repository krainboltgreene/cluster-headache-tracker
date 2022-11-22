defmodule CoreWeb.EntryLive.FormComponent do
  use CoreWeb, :live_component

  alias Core.HealthIssues

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>
          Use this form to manage entry records in your database.
        </:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="entry-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={{f, :context}}
          type="select"
          label="context"
          options={["ongoing", "end", "restart"]}
        />
        <.input
          field={{f, :severity}}
          type="select"
          label="severity"
          options={1..10 |> Enum.map(&Integer.to_string/1)}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cluster headache entry</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{entry: entry} = assigns, socket) do
    changeset = HealthIssues.change_entry(entry)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event(
        "validate",
        %{"entry" => entry_params},
        socket
      ) do
    changeset =
      socket.assigns.entry
      |> HealthIssues.change_entry(
        entry_params
        |> Map.put("cluster_headache", socket.assigns.cluster_headache)
      )
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"entry" => entry_params}, socket) do
    save_entry(
      socket,
      socket.assigns.action,
      entry_params |> Map.put("cluster_headache", socket.assigns.cluster_headache)
    )
  end

  defp save_entry(socket, :edit, entry_params) do
    case HealthIssues.update_entry(
           socket.assigns.entry,
           entry_params
         ) do
      {:ok, _entry} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster headache entry updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_entry(socket, :new, entry_params) do
    case HealthIssues.create_entry(entry_params) do
      {:ok, _entry} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cluster headache entry created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
