defmodule WorbeeWeb.GameLive do
  use WorbeeWeb, :live_view

  alias Worbee.Game.{Words, Core}
  alias Worbee.Games
  alias Worbee.Games.Guess

  import WorbeeWeb.WorbeeComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event(
        "make-guess",
        %{
          "guess" => %{
            "guess" => guess
          }
        } = params,
        %{
          assigns: %{
            user_game: %{
              id: user_game_id
            }
          }
        } = socket
      ) do
    case Games.create_guess(%Guess{}, %{
           guess: guess,
           user_game_id: user_game_id
         }) do
      {:ok, _} ->
        game = Core.add_guess(socket.assigns.game, guess)

        {:noreply, assign(socket, :game, game)}

      {:error, changeset} ->
        form = to_form(changeset)

        {:noreply, assign(socket, form: form)}
    end
  end

  @impl true
  def handle_event("start", %{"mode" => mode}, socket) do
    {:ok, user_game} =
      Games.create_or_get_user_game(%{
        user_id: socket.assigns.current_user.id,
        mode: mode,
        answer: Words.random_answer()
      })

    {:noreply, push_patch(socket, to: ~p"/game/#{user_game}")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, params, socket.assigns.live_action)}
  end

  defp apply_action(socket, %{"id" => user_game_id}, :play) do
    user_game = Games.get_user_game!(user_game_id)

    game = Core.init(user_game.answer)

    socket
    |> assign(:game, game)
    |> assign(:form, to_form(Guess.changeset(%Guess{}, %{})))
    |> assign(:user_game, user_game)
  end

  defp apply_action(socket, _params, :new) do
    socket
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

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      game = Core.add_guess(socket.assigns.game, Ecto.Changeset.get_change(changeset, :guess))

      socket
      |> assign(:game, game)
      |> assign(form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
