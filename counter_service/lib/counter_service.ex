defmodule CounterService do
  @moduledoc """
  Documentation for `CounterService`.
  """

  @doc """
  Client side.
  Start a counter service.
  """
  def start(input) do
    spawn(fn -> input |> String.to_integer() |> loop() end)
  end

  def inc(counter) do
    send(counter, :inc)
  end

  def show(counter) do
    send(counter, {:show, self()})

    receive do
      message ->
        message
    end
  end

  # Server side functions
  defp loop(count) do
    count |> listen() |> loop()
  end

  defp listen(count) do
    receive do
      :inc ->
        count + 1

      {:show, from_pid} ->
        send(from_pid, count)
        count
    end
  end
end
