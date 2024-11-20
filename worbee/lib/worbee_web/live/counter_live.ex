defmodule WorbeeWeb.CounterLive do
  use WorbeeWeb, :live_view

  alias Worbee.Counter

  def render(assigns) do
    ~H"""
    <div>
      <pre>
        <%= inspect(@counter, pretty: true) %>
      </pre>
      <hr>
      <pre>
        <%= inspect(assigns, pretty: true) %>
      </pre>
      <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" phx-click="increment">
        <%= Counter.show(@counter) %>
      </button>
    </div>
    """
  end

  def handle_event("increment", _value, socket) do
    counter = socket.assigns.counter |> Counter.inc

    {:noreply, assign(socket, :counter, counter)}
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, :counter, Counter.new())

    {:ok, socket}
  end
end
