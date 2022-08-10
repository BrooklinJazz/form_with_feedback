defmodule FormWithFeedback.Input do
  @moduledoc """
  FormWithFeedback.Input

  A Kino.JS.Live component
  """
  use Kino.JS
  use Kino.JS.Live

  @doc """
  Create a new component.

    ## Examples

    Create a single component
    InputWithFeedback.new("input", ["hello"])

    Rendering multiple components
    InputWithFeedback.new("input", ["hello", "bob"]) |> Kino.render()
    InputWithFeedback.new("input", ["hello", "bob"])
  """
  def new(label, answers) when is_list(answers) do
    Kino.JS.Live.new(__MODULE__, {label, answers})
  end

  @impl true
  def init({label, answers}, ctx) do
    {:ok, assign(ctx, label: label, answers: answers, input: "")}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{input: ctx.assigns.input, answers: ctx.assigns.answers, label: ctx.assigns.label},
     ctx}
  end

  @impl true
  def handle_event("update", %{"input" => input}, ctx) do
    broadcast_event(ctx, "update", %{"input" => input, "correct" => input in ctx.assigns.answers})
    {:noreply, assign(ctx, input: input)}
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css")
      ctx.root.innerHTML = `
        <p>${payload.label}</p>
        <input class="input" autocomplete="false" id="input" />
      `;

      const input = ctx.root.querySelector("#input");

      input.addEventListener("input", (event) => {
        console.log("OH")
        ctx.pushEvent("update", { input: event.target.value });
      });

      ctx.handleEvent("update", ({ correct, input: input_text }) => {
        input.value = input_text
        if (correct) {
          input.classList.add("correct");
        } else {
          input.classList.remove("correct");
        }
      });
    }
    """
  end

  asset "main.css" do
    """
    .input {
      border-radius: 0.5rem;
      border-width: 1px;
      border: solid 1px rgb(225 232 240);
      font-size: .875rem;
      line-height: 1.25rem;
      padding: .5rem .75rem;
      box-sizing: border-box;
      background-color: #F8FAFC;
      width: 215px;
    }

    .input:focus {
      outline: none;
    }
    .correct {
      background-color: lightgreen;
    }
    """
  end
end
