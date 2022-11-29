defmodule CoreWeb.TimelineComponent do
  use CoreWeb, :live_component

  @impl true
  def handle_event("request-timeline-data", _params, socket) do
    socket
    |> push_event("load-timeline-data", %{
      datasets: Enum.concat(
        if socket.assigns[:entries] do
          socket.assigns.entries
          |> Enum.group_by(fn entry -> entry.aliment end)
          |> Enum.map(fn {aliment, entries} ->
            %{
              type: "scatter",
              label: aliment.name,
              data: entries
              |> Enum.map(fn entry ->
                %{
                  x: timestamp(entry.inserted_at),
                  y: entry.severity
                }
              end),
            }
          end)
        else
          []
        end,
        if socket.assigns[:treatments] do
          socket.assigns.treatments
          |> Enum.with_index(1)
          |> Enum.map(fn {treatment, index} ->
            %{
              type: if treatment.medication.cooldown > 0 do "line" else "bar" end,
              label: treatment.medication.name,
              data: [
                %{x: timestamp(treatment.inserted_at), y: index},
                if treatment.medication.cooldown > 0 do
                  %{x: timestamp(Timex.add(treatment.inserted_at, Timex.Duration.from_hours(treatment.medication.cooldown))), y: index}
                end
              ]
              |> Enum.reject(&is_nil/1)
            }
          end)
        else
          []
        end
      )
      |> Enum.reject(&is_nil/1)
          # %{
          #   type: "line",
          #   label: "Treatments",
          #   spanGaps: true,
          #   radius: 0,
          #   data: socket.assigns.treatments
          #   |> Enum.with_index(1)
          #   |> Enum.flat_map(fn {treatment, index} ->
          #     [
          #       %{x: timestamp(treatment.inserted_at), y: index},
          #       if treatment.medication do
          #         %{x: timestamp(treatment.inserted_at), y: index}
          #       end,
          #       nil
          #     ]
          #   end),
          # }
    })
    |> (&{:noreply, &1}).()
  end

  defp timestamp(value) do
    value
    |> Timex.Timezone.convert(Timex.Timezone.get("America/Los_Angeles"))
    |> NaiveDateTime.to_iso8601()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <canvas phx-hook="TimelineComponent" id={@id} phx-target={@myself} role="img"></canvas>
    """
  end
end
