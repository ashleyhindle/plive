defmodule PliveWeb.Router do
  use PliveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PliveWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :og_image do
    plug :accepts, ["html", "png"]
    plug :put_root_layout, false
    plug :put_layout, html: {PliveWeb.Layouts, :og_image}
  end

  scope "/", PliveWeb do
    pipe_through :browser

    live "/", HomeLive
  end

  scope "/og/", PliveWeb do
    pipe_through :og_image

    get "/image", OgImageController, :show
    get "/preview", OgImageController, :show
  end
end
