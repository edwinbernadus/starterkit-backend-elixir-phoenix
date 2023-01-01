defmodule HelloWeb.Router do
  # alias HelloController
  # alias InfoController
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HelloWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", PageController, :hello
    get "/hello-world", PageController, :hello_world
    get "/hello/:messenger", InfoController, :show
    get "/hello2/:messenger", InfoController, :show_json
    get "/hello-index", HelloController, :index
    get "/info-random", InfoController, :show_random



  end

  # Other scopes may use custom stacks.
  scope "/api", HelloWeb do
    pipe_through :api

    post "/display-post-raw", InfoController, :display_post_raw_data
    post "/display-post-model", InfoController, :display_post_model_json
    get "/get-header", InfoController, :get_header
    get "/get-json", InfoController, :display_json_convert


    get "/insert-db", InfoController, :insert_db
    get "/update-db", InfoController, :update_db
    get "/get-list-db", InfoController, :get_list_db
    get "/get-detail-db", InfoController, :get_list_one_item
    get "/delete-db", InfoController, :delete_db
    get "/count-db", InfoController, :get_total_rows

    get "/sample-add-number", InfoController, :generate_sample_add_number
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
