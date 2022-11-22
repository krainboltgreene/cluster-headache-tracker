defmodule CoreWeb.AccountResetPasswordLive do
  use CoreWeb, :live_view

  alias Core.Users

  def render(assigns) do
    ~H"""
    <.header>Reset Password</.header>

    <.simple_form
      :let={f}
      for={@changeset}
      id="reset_password_form"
      phx-submit="reset_password"
      phx-change="validate"
    >
      <.error :if={@changeset.action == :insert}>
        Oops, something went wrong! Please check the errors below.
      </.error>

      <.input field={{f, :password}} type="password" label="New password" required />
      <.input
        field={{f, :password_confirmation}}
        type="password"
        label="Confirm new password"
        required
      />
      <:actions>
        <.button phx-disable-with="Resetting...">Reset Password</.button>
      </:actions>
    </.simple_form>

    <p>
      <.link href={~p"/accounts/register"}>Register</.link>
      |
      <.link href={~p"/accounts/log_in"}>Log in</.link>
    </p>
    """
  end

  def mount(params, _session, socket) do
    socket = assign_account_and_token(socket, params)

    socket =
      case socket.assigns do
        %{account: account} ->
          assign(socket, :changeset, Users.change_account_password(account))

        _ ->
          socket
      end

    {:ok, socket, temporary_assigns: [changeset: nil]}
  end

  # Do not log in the account after reset password to avoid a
  # leaked token giving the account access to the account.
  def handle_event("reset_password", %{"account" => account_params}, socket) do
    case Users.reset_account_password(socket.assigns.account, account_params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Password reset successfully.")
         |> redirect(to: ~p"/accounts/log_in")}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, Map.put(changeset, :action, :insert))}
    end
  end

  def handle_event("validate", %{"account" => account_params}, socket) do
    changeset = Users.change_account_password(socket.assigns.account, account_params)
    {:noreply, assign(socket, changeset: Map.put(changeset, :action, :validate))}
  end

  defp assign_account_and_token(socket, %{"token" => token}) do
    if account = Users.get_account_by_reset_password_token(token) do
      assign(socket, account: account, token: token)
    else
      socket
      |> put_flash(:error, "Reset password link is invalid or it has expired.")
      |> redirect(to: ~p"/")
    end
  end
end
