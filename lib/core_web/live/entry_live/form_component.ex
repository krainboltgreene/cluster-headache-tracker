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
          label="Context"
          options={["ongoing", "end"]}
        />
        <.input
          field={{f, :severity}}
          type="select"
          label="Severity"
          options={0..10 |> Enum.map(&Integer.to_string/1)}
        />
        <picture style="display: flex; justify-content: center;">
          <img id="head" src={~p"/images/head.jpg"} />
          <% if @entry.x || @entry.y do %>
            <svg id="surface" viewBox="0 0 340 480" width="340px" height="480px" style="position: absolute;" xmlns="http://www.w3.org/2000/svg">
              <circle cx={@entry.x} cy={@entry.y} r={@entry.radius * 13} fill="rgba(240, 40, 40, 0.40)" />
              <circle cx={@entry.x} cy={@entry.y} r={@entry.radius * 8} fill="rgba(240, 40, 40, 0.60)" />
              <circle cx={@entry.x} cy={@entry.y} r={@entry.radius * 5} fill="rgba(240, 40, 40, 0.80)" />
            </svg>
          <% end %>
        </picture>
        <script>
          document.getElementById('head').addEventListener("click", function clickRecordCoordinate({offsetX, offsetY}) {
            document.getElementById('entry-form_x').value = offsetX;
            document.getElementById('entry-form_y').value = offsetY;
          });
        </script>
        <.input
          field={{f, :x}}
          type="hidden"
        />
        <.input
          field={{f, :y}}
          type="hidden"
        />
        <.input
          field={{f, :radius}}
          type="number"
          label="Radius"
        />
        <.input
          field={{f, :notes}}
          type="textarea"
          label="Note"
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Entry</.button>
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
         |> put_flash(:info, "Entry updated successfully")
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
         |> put_flash(:info, "Entry created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
