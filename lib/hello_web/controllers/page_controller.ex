defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  # //get
  def hello(conn, _params) do
    render(conn, "hello.html")
  end

  def hello_world(conn, _params) do
    render(conn, "world.html")
  end



end
