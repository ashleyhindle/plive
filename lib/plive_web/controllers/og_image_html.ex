defmodule PliveWeb.OgImageHTML do
  use PliveWeb, :html

  @doc """
  A logo and text on a light background.
  """
  def light(assigns) do
    ~H"""
    <body class="bg-[#F8F2E6] flex flex-col h-screen">
      <div class="shrink-0 pt-24 px-20 text-gray-900">
        logo goes here
      </div>
      <div class="grow flex items-center px-20">
        <h1 class="font-extrabold text-gray-900 text-[7rem] leading-[1.2]">
          <%= @text %>
        </h1>
      </div>
    </body>
    """
  end

  @doc """
  A fallback image.
  """
  def fallback(assigns) do
    ~H"""
    <body class="bg-[#F8F2E6] flex items-center justify-center h-screen">
      <div>
        logo goes here
      </div>
    </body>
    """
  end
end
