defmodule WorbeeWeb.WorbeeComponents do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

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

  defp color(game_color) do
    "bg-#{to_string(game_color)}-100"
  end
end
