defmodule PliveWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use PliveWeb, :controller` and
  `use PliveWeb, :live_view`.
  """
  use PliveWeb, :html

  embed_templates "layouts/*"

  @doc """
  Renders a <style> block containing all Tailwind utilities, fonts, and other
  styles that should be present on the page for image templates.
  """
  def image_template_styles(assigns) do
    ~H"""
    <style>
      /**
       * Include Inter font.
       */
      @font-face {
        font-family: InterVariable;
        font-style: normal;
        font-weight: 100 900;
        font-display: swap;
        src: url(<%= font_to_base64_url("InterVariable.woff2") %>) format("woff2");
      }

      @font-face {
        font-family: InterVariable;
        font-style: italic;
        font-weight: 100 900;
        font-display: swap;
        src: url(<%= font_to_base64_url("InterVariable-Italic.woff2") %>) format("woff2");
      }

      :root {
        font-family: InterVariable, sans-serif;
        font-feature-settings: 'liga' 1, 'calt' 1; /* fix for Chrome */
      }

      /* Include all styles from `app.css` */

      <%= raw(app_css()) %>
    </style>
    """
  end

  # Private helpers

  defp app_css do
    File.read!(Path.join([Application.app_dir(:plive), "priv/static/assets/app.css"]))
  end

  defp font_to_base64_url(file_name) do
    data =
      [Application.app_dir(:plive), "priv/og_image_fonts/#{file_name}"]
      |> Path.join()
      |> File.read!()
      |> Base.encode64()

    "data:font/woff2;charset=utf-8;base64,#{data}"
  end

  # defp image_to_base64_url(file_name) do
  #   content_type = MIME.from_path(file_name)

  #   data =
  #     [Application.app_dir(:plive), "priv/static/images/#{file_name}"]
  #     |> Path.join()
  #     |> File.read!()
  #     |> Base.encode64()

  #   "data:#{content_type};base64,#{data}"
  # end
end
