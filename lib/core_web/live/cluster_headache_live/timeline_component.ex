defmodule CoreWeb.ClusterHeadacheLive.TimelineComponent do
  use CoreWeb, :live_component

  @impl true
  def handle_event("request-timeline-data", _params, socket) do
    socket
    |> push_event("load-timeline-data", %{
      "data" => socket.assigns.cluster_headaches
      |> Enum.flat_map(fn cluster_headache ->
        [
          %{
            "timestamp" => NaiveDateTime.to_iso8601(cluster_headache.inserted_at),
            "severity" => 1
          }
          |
          Enum.map(cluster_headache.entries, fn entry ->
            %{
              "timestamp" => NaiveDateTime.to_iso8601(entry.inserted_at),
              "severity" => entry.severity
            }
          end)
        ]
      end)
    })
    |> (&{:noreply, &1}).()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div phx-hook="TimelineComponent" id={@id} phx-target={@myself} ></div>
    """
  end
end
