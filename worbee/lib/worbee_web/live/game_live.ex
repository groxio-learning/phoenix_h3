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
  def handle_event("make-guess", params, socket) do
    {:noreply, make_guess(socket, params)}
  end

  def handle_event("start", %{"mode" => mode}, socket) do
    {:ok, user_game} =
      Games.create_or_get_user_game(%{
        user_id: socket.assigns.current_user.id,
        mode: mode,
        answer: Words.random_answer()
      })

    {:noreply, push_patch(socket, to: ~p"/game/#{user_game}")}
  end

  def handle_event("validate", params, socket) do
    {:noreply, validate(socket, params["guess"]) }
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, params, socket.assigns.live_action)}
  end

  defp validate(socket, params) do
    changeset = Guess.changeset(%Guess{}, params)

    assign(socket, form: to_form(changeset))
  end

  defp apply_action(socket, %{"id" => user_game_id}, :play) do
    user_game = Games.get_user_game!(user_game_id)

    game = Core.init(user_game.answer)

    socket
    |> assign(:game, game)
    |> clear_form()
    |> assign(:user_game, user_game)
  end

  defp apply_action(socket, _params, :new) do
    socket
  end

  defp clear_form(socket), do: assign(socket, :form, to_form(Guess.changeset(%Guess{}, %{})))

  defp make_guess(socket, params) do
    case Games.create_guess(%Guess{}, %{
           guess: params["guess"]["guess"],
           user_game_id: socket.assigns.user_game.id
         }) do
      {:ok, _} ->
        socket
        |> assign(game: Core.add_guess(socket.assigns.game, params["guess"]["guess"]))
        |> clear_form()

      {:error, changeset} ->
        assign(socket, form: to_form(changeset))
    end
  end
end
