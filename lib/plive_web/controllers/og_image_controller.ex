defmodule PliveWeb.OgImageController do
  use PliveWeb, :controller

  import PliveWeb.ImageHelpers
  import PliveWeb.ImageRenderer

  def show(conn, %{"text" => text}) do
    conn
    |> assign(:text, prepare_html(text))
    |> render_image(:light)
  end

  # -- Add more templates here --

  def show(conn, _params) do
    render_image(conn, :fallback)
  end
end
