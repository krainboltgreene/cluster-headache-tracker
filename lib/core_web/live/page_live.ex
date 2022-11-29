defmodule CoreWeb.PageLive do
  use CoreWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        HIT
        <:subtitle>
          Health Issue Tracker
        </:subtitle>
      </.header>

      <.live_component
        module={CoreWeb.TimelineComponent}
        id="timeline"
        entries={@entries}
        treatments={@treatments}
      />

      <%= if @current_account do %>
        <ul>
          <li>
            <.link href={~p"/entries"}>Entries</.link>
          </li>
          <li>
            <.link href={~p"/aliments"}>Aliments</.link>
          </li>
          <li>
            <.link href={~p"/treatments"}>Treatments</.link>
          </li>
          <li>
            <.link href={~p"/medications"}>Medications</.link>
          </li>
        </ul>
      <% else %>
        <ul>
          <li>
            <.link href={~p"/accounts/register"}>Register</.link>
          </li>
          <li>
            <.link href={~p"/accounts/log_in"}>Log in</.link>
          </li>
        </ul>
      <% end %>
    </div>

    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :home, _params) do
    socket
    |> assign(:page_title, "Home")
    |> assign(:entries, Core.HealthIssues.list_entries() |> Core.Repo.preload([:aliment]))
    |> assign(:treatments, Core.HealthIssues.list_treatments() |> Core.Repo.preload([:medication]))
  end
end
