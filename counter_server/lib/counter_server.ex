defmodule CounterServer do
  use GenServer
  alias Counter

  # Client
  def start_link(default) when is_binary(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def show(pid) do
    GenServer.call(pid, :show)
  end

  def inc(pid) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid) do
    GenServer.cast(pid, :dec)
  end

  # Server (callbacks)

  @impl true
  def init(input) do
    initial_state = Counter.new(input)
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:show, _from, state) do
    {:reply, Counter.show(state), state}
  end

  @impl true
  def handle_cast(:inc, counter) do
    {:noreply, Counter.increment(counter)}
  end

  def handle_cast(:dec, counter) do
    {:noreply, Counter.decrement(counter)}
  end
end
