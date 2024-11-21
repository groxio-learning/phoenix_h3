defmodule WorbeeWeb.GameLive do
  use WorbeeWeb, :live_view

  alias Worbee.Game.{Words, Core}
  import WorbeeWeb.WorbeeComponents

  @impl true
  def mount(_params, _session, socket) do
    game = Core.init(Words.random_answer())

    socket =
      socket
      |> assign(:game, game)
      |> assign(:form, to_form(%{"guess" => "Guess"}))

    {:ok, socket}
  end

  @impl true
  def handle_event("make-guess", %{"guess" => guess}, socket) do
    game = Core.add_guess(socket.assigns.game, guess)

    {:noreply, assign(socket, :game, game)}
  end

  @impl true
  def handle_event("start", %{"mode" => _mode}, socket) do
    # create the UserGame
    id = 4
    {:noreply, push_patch(socket, to: ~p"/game/#{id}")}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div :if={@live_action == :play}>
      <div class="bg-green-100 bg-gray-100 bg-yellow-100"></div>
      <%!-- <%= inspect(@game) %> --%>
      <.guess_form form={@form} />

      <.guesses game={@game} words={Enum.reverse(Core.show_guesses(@game))} />
    </div>
    <div :if={@live_action == :new}>
      <.button phx-click="start" phx-value-mode="random">Random</.button>
      <.button phx-click="start" phx-value-mode="daily">Daily</.button>
    </div>
    """
  end
end
