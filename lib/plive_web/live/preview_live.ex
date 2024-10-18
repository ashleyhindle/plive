defmodule PliveWeb.PreviewLive do
  use PliveWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="poll-preview">
      <h1 class="text-3xl font-bold mb-4"><%= @poll.question %></h1>
      <div class="options">
        <%= for option <- @poll.options do %>
          <div class="option mb-4">
            <div class="flex items-center">
              <div class="w-32"><%= option.text %></div>
              <div class="flex-grow">
                <div
                  class="h-6 rounded"
                  style={"width: #{@votes[option.id].percentage}%; background-color: #{generate_color(option.text)}"}
                >
                </div>
              </div>
              <div class="w-32 text-right">
                <%= @votes[option.id].count %> votes (<%= @votes[option.id].percentage %>%)
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def update(assigns, socket) do
    votes = generate_random_votes(assigns.poll.options)
    {:ok, assign(socket, poll: assigns.poll, votes: votes)}
  end

  defp generate_random_votes(options) do
    total_votes = Enum.random(20..185)
    votes = Enum.map(options, fn _ -> Enum.random(10..(total_votes - 10)) end)
    total = Enum.sum(votes)

    options
    |> Enum.zip(votes)
    |> Enum.map(fn {option, vote_count} ->
      percentage = if total == 0, do: 0, else: round(vote_count / total * 100)
      {option.id, %{count: vote_count, percentage: percentage}}
    end)
    |> Enum.into(%{})
  end

  defp generate_color(text) do
    # Use a hash function to generate a consistent integer from the text
    hash = :erlang.phash2(text)

    # Use the hash to generate RGB values
    r = rem(hash, 256)
    g = rem(div(hash, 256), 256)
    b = rem(div(hash, 65536), 256)

    # Convert to hex and ensure each component has two digits
    "##{to_hex(r)}#{to_hex(g)}#{to_hex(b)}"
  end

  defp to_hex(n) do
    n
    |> Integer.to_string(16)
    |> String.pad_leading(2, "0")
  end
end
