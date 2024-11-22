defmodule WorbeeWeb.DashLive do
  use WorbeeWeb, :live_view
  alias Worbee.Games
  import WorbeeWeb.WorbeeComponents

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      IO.inspect("subscribed")
      Games.subscribe()
    end

    {:ok, assign(socket, :games, %{})}
  end

  @impl true
  def handle_info({game, id}, socket) do
    {:noreply, add_game(socket, game, id)}
  end

  def add_game(socket, game, id) do
    games = Map.put(socket.assigns.games, id, game)
    assign(socket, games: games)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <pre>
      <%= for {id, game} <- @games do %>
        <.guesses words={Enum.reverse(game.guesses)} game={game} />
      <% end %>
    </pre>
    """
  end
end
