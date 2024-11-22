defmodule WorbeeWeb.DashLive do
  use WorbeeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    Hi Admin
    """
  end
end
