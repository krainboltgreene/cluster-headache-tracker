defmodule CoreWeb.TimelineComponent do
  use CoreWeb, :live_component

  @impl true
  def handle_event("request-timeline-data", _params, socket) do
    socket
    |> push_event("load-timeline-data", %{
      datasets: [
        if socket.assigns[:entries] do
          %{
            type: "line",
            label: "Entries",
            data: socket.assigns.entries
            |> Enum.map(fn entry ->
              %{
                x: NaiveDateTime.to_iso8601(Timex.Timezone.convert(entry.inserted_at, Timex.Timezone.get("America/Los_Angeles"))),
                y: entry.severity
              }
            end),
          }
        end,
        if socket.assigns[:treatments] do
          %{
            type: "line",
            label: "Treatments",
            data: socket.assigns.treatments
            |> Enum.map(fn treatment ->
              %{
                x: NaiveDateTime.to_iso8601(Timex.Timezone.convert(treatment.inserted_at, Timex.Timezone.get("America/Los_Angeles"))),
                y: treatment.medicine.cooldown
              }
            end),
          }
        end
      ] |> Enum.reject(&is_nil/1),
      labels: []
    })
    |> (&{:noreply, &1}).()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <canvas phx-hook="TimelineComponent" id={@id} phx-target={@myself} role="img"></canvas>
    """
  end
end
