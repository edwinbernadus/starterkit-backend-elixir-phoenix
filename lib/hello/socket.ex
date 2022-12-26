defmodule EchoSocket do
  @behaviour Phoenix.Socket.Transport

  def child_spec(opts) do
    # We won't spawn any process, so let's return a dummy task
    %{id: __MODULE__, start: {Task, :start_link, [fn -> :ok end]}, restart: :transient}
  end

  def connect(state) do
    # Callback to retrieve relevant data from the connection.
    # The map contains options, params, transport and endpoint keys.
    {:ok, state}
  end

  def init(state) do
    # Now we are effectively inside the process that maintains the socket.
    {:ok, state}
  end

  def handle_in({text, _opts}, state) do
    IO.inspect("handle_in")
    IO.inspect(text)
    # //web_socket
    output = "reply: " <> text

    {:reply, :ok, {:text, output}, state}
  end

  def handle_info(_, state) do
    IO.inspect("handle_info")
    IO.inspect(state)
    {:ok, state}
  end

  def terminate(_reason, _state) do
    :ok
  end
end
