defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    # Logger.info  "Hello controller start"
    render(conn, "index.html")
  end
end
