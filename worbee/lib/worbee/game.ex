defmodule Worbee.Game do
  @moduledoc """
  Worbee keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  use GenServer

  alias Worbee.Game.Core

  def start_link(default) when is_binary(default) do
    GenServer.start_link(__MODULE__, default, name: :worbee)
  end

  def add_guess(pid, guess) do
    GenServer.cast(pid, {:add_guess, guess})
  end

  def show(pid) do
    GenServer.call(pid, :show)
  end

  def show_guesses(pid) do
    GenServer.call(pid, :show_guesses)
  end

  # Server (callbacks)

  @impl true
  def init(answer) do
    initial_state = Core.init(answer)
    {:ok, initial_state}
  end

  @impl true
  def handle_cast({:add_guess, guess}, state) do
    updated_state = state |> Core.add_guess(guess)
    {:noreply, updated_state}
  end

  @impl true
  def handle_call(:show, _from, state) do
    result = Core.compute_latest_guess(state)
    {:reply, result, state}
  end

  @impl true
  def handle_call(:show_guesses, _from, state) do
    result = Core.show_guesses(state)
    {:reply, result, state}
  end
end
