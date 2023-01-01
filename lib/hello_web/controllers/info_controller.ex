defmodule HelloWeb.InfoController do
  alias Hello.AlbumModule
  use HelloWeb, :controller

  # //routing_id
  def show(conn, %{"messenger" => messenger}) do
    # Logger.info  "Logging this text!"
    # Logger.info  "Logging this text! 2" + _params

    # IO.puts "Hello World"
    # IO.puts "info messenger: " <> messenger

    # IEx.pry()
    render(conn, "info.html", messenger: messenger)
  end

  # //json_convert
  def show_json(conn, %{"messenger" => messenger}) do
    json(conn, %{id_data: messenger})
  end

  # //post
  def display_post_raw_data(conn, _params) do
    {:ok, body, _conn} = read_body(conn)
    json(conn, %{result: body})
  end


#  {
#     "title" : "one",
#     "amount" : 12421.3213,
#     "requestRate" : 11.24141251251,
#     "name" : "hello world",
#     "number1" : 789
# }

  def display_post_model_json(conn, _params) do
    {:ok, body, _conn} = read_body(conn)
    # //post_body_to_model
    output = Poison.decode!(body)
    output2 = to_string(output["name"]) <> " + " <> to_string(output["number1"])
    json(conn, %{result: output2})
  end

  # //json_convert
  def display_json_convert(conn, _params) do
    data = %{name: "Alice", age: 30}
    # output = Poison.encode!(data)
    # json(conn, %{result: output})
    json(conn, %{result: data})
  end

  # //get_header
  def get_header(conn, _params) do
    case get_req_header(conn, "authorization") do
      # nil ->
      #   # The header was not present in the request
      #   conn
      #   |> put_status(401)
      #   |> json(%{error: "Unauthorized"})
      value ->
        # The header was present, do something with its value
        # ...
        json(conn, %{result: value})
    end
  end

  def show_random(conn, _params) do
    output = %{a: 1, b: 22222}
    IO.puts("Hello World 123" <> " " <> to_string(output.a) <> " " <> to_string(output.b))
    IO.inspect(output)
    json(conn, %{id_data: output.b})
  end

  def insert_db(conn, _params) do
    model = %{title: "Alice", privacy: "privacy1", subtitle: "subtitle1"}
    # //sql_create
    AlbumModule.create_album(model)
    json(conn, %{output: model})
  end

  def update_db(conn, _params) do
    model = AlbumModule.get_album!(2)
    IO.inspect("model")
    IO.inspect(model)

    # //sql_update
    AlbumModule.update_album(model, %{subtitle: "subtitle2"})
    json(conn, %{output: "updated"})
  end

  def get_list_db(conn, _params) do
    # //sql_select_list
    data = AlbumModule.list_albums()

    # data_0 = Enum.map(data, fn x -> Map.delete(x, :__meta__) end)
    # data_1 = Enum.map(data_0, fn x -> Map.delete(x, :inserted_at) end)
    # data_2 = Enum.map(data_1, fn x -> Map.delete(x, :updated_at) end)
    # cleaned_data = Enum.map(data_2, fn x -> Map.delete(x, :__struct__) end)

    cleaned_data = Utility2.clean_up_data(data)

    # item2 = Enum.at(data,0)
    # IO.inspect "item2"
    # IO.inspect item2

    json(conn, %{output: cleaned_data})
  end

  def get_list_one_item(conn, _params) do
    model = AlbumModule.get_album!(1)
    output = Poison.encode!(model)
    json(conn, %{output: output})
  end

  def get_total_rows(conn, _params) do
    total = AlbumModule.count_total_rows_in_table()
    IO.inspect("total")
    IO.inspect(total)
    json(conn, %{output: total})
  end

  def delete_db(conn, _params) do
    model = AlbumModule.get_album!(1)
    AlbumModule.delete_album(model)
    json(conn, %{output: "deleted"})
  end


  def generate_sample_add_number(conn, _params) do
    output = Utility2.addNumber(1,2)
    json(conn, %{output: output})
  end
end
