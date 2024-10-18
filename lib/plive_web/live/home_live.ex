defmodule PliveWeb.HomeLive do
  use PliveWeb, :live_view

  alias Plive.Schemas.Poll
  alias PliveWeb.PreviewLive

  def mount(_params, _session, socket) do
    {:ok, assign(socket, poll_form: nil, poll: nil)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <button
        :if={!@poll}
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        phx-click="create_poll"
      >
        Create Poll
      </button>

      <%= if @poll_form do %>
        <h1>Create your poll</h1>
        Share your poll: <%= @poll.slug %>

        <.form
          :let={poll}
          for={@poll_form}
          id="update-poll-form"
          phx-change="validate"
          phx-submit="update"
        >
          <.input
            field={@poll_form[:question]}
            type="text"
            label="Question"
            placeholder="What is the meaning of life?"
          />
          <.inputs_for :let={option} field={poll[:options]}>
            <.input
              field={option[:text]}
              type="text"
              label={"Option #{option.index + 1}"}
              placeholder="42"
            />
          </.inputs_for>
          <.button type="submit">Update</.button>
        </.form>

        <h2 class="text-2xl font-bold mt-8 mb-4">Preview</h2>
        <.live_component module={PreviewLive} id="poll-preview" poll={@poll} key={@poll.updated_at} />
      <% end %>
    </div>
    """
  end

  # Create poll button, creates the initial basic poll for the user to edit
  def handle_event("create_poll", _params, socket) do
    options = [%{text: "Yes"}, %{text: "No"}]
    slug = generate_slug()

    case Plive.create_poll(%{question: "Do you love cheddar?", options: options, slug: slug}) do
      {:ok, poll} ->
        new_changeset = poll |> Poll.changeset(%{})
        {:noreply, assign(socket, poll_form: to_form(new_changeset), poll: poll)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        {:noreply, assign(socket, poll_form: to_form(changeset))}
    end
  end

  def handle_event("validate", %{"poll" => params}, socket) do
    changeset =
      socket.assigns.poll
      |> Poll.changeset(params)
      |> Map.put(:action, :validate)

    if changeset.valid? do
      updated_poll = Ecto.Changeset.apply_changes(changeset)

      {:noreply,
       socket
       |> assign(:poll_form, to_form(changeset))
       |> assign(:poll, updated_poll)}
    else
      {:noreply, assign(socket, poll_form: to_form(changeset))}
    end
  end

  def handle_event("update", %{"poll" => params}, socket) do
    case Plive.update_poll(socket.assigns.poll, params) do
      {:ok, updated_poll} ->
        {:noreply,
         socket
         |> assign(:poll_form, to_form(Poll.changeset(updated_poll, %{})))
         |> assign(:poll, updated_poll)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, poll_form: to_form(changeset))}
    end
  end

  defp generate_slug, do: Nanoid.generate_non_secure(9, "0123456789abcdefghijklmnopqrstuvwxyz")
end
