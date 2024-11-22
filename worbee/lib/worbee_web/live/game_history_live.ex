defmodule WorbeeWeb.GameHistoryLive do
  use WorbeeWeb, :live_view

  alias Worbee.Games

  @impl true
  def mount(_params, _session, socket) do
    user_games = Games.list_user_games()
    {:ok, assign(socket, :user_games, user_games)}
  end

  @impl true
  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

  # @impl true
  # def handle_event("make-guess", params, socket) do
  #   {:noreply, make_guess(socket, params)}
  # end

  # def handle_event("start", %{"mode" => mode}, socket) do
  #   {:ok, user_game} =
  #     Games.create_or_get_user_game(%{
  #       user_id: socket.assigns.current_user.id,
  #       mode: mode,
  #       answer: Words.random_answer()
  #     })

  #   {:noreply, push_patch(socket, to: ~p"/game/#{user_game}")}
  # end

  # def handle_event("validate", params, socket) do
  #   {:noreply, validate(socket, params["guess"]) }
  # end

  # def handle_params(params, _uri, socket) do
  #   {:noreply, apply_action(socket, params, socket.assigns.live_action)}
  # end
end
