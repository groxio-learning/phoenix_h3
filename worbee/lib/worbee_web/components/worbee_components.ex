defmodule WorbeeWeb.WorbeeComponents do
  use Phoenix.Component

  alias Worbee.Game.Core
  import WorbeeWeb.CoreComponents

  attr(:character, :atom, required: true)
  attr(:color, :atom, required: true)

  def letter(assigns) do
    ~H"""
    <p class={"p-4 font-mono flex #{color(@color)} uppercase"}><%= @character %></p>
    """
  end

  attr(:letters, :list, required: true)

  def word(assigns) do
    ~H"""
    <span :for={{c, color} <- @letters} class="flex">
      <.letter character={c} color={color} />
    </span>
    """
  end

  attr(:words, :list, required: true)
  attr(:game, Core, required: true)

  def guesses(assigns) do
    ~H"""
    <ul>
      <li :for={guess <- @words} class="flex">
        <.word letters={Core.compute_guess(@game, guess)} />
      </li>
    </ul>
    """
  end

  attr(:form, :any, required: true)

  def guess_form(assigns) do
    ~H"""
    <.simple_form for={@form} phx-submit="make-guess" phx-change="validate-guess">
      <.input field={@form["guess"]} />
      <.button>submit</.button>
    </.simple_form>
    """
  end

  defp color(game_color) do
    "bg-#{to_string(game_color)}-100"
  end
end
