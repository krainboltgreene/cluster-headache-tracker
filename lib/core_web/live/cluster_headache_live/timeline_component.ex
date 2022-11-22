defmodule CoreWeb.ClusterHeadacheLive.TimelineComponent do
  use CoreWeb, :live_component

  @impl true
  def handle_event("request-timeline-data", _params, socket) do
    socket
    |> push_event("load-timeline-data", %{
      "data" => [
        %{
          label: "person a",
          times: [
            %{"starting_time" => 1_355_752_800_000, "ending_time" => 1_355_759_900_000},
            %{"starting_time" => 1_355_767_900_000, "ending_time" => 1_355_774_400_000}
          ]
        },
        %{
          label: "person b",
          times: [
            %{"starting_time" => 1_355_759_910_000, "ending_time" => 1_355_761_900_000}
          ]
        },
        %{
          label: "person c",
          times: [
            %{"starting_time" => 1_355_761_910_000, "ending_time" => 1_355_763_910_000}
          ]
        }
      ]
    })
    |> (&{:noreply, &1}).()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div phx-hook="TimelineComponent" id={@id} phx-target={@myself}></div>
    """
  end
end
