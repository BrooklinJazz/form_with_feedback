defmodule FormWithFeedback.MixProject do
  use Mix.Project

  def project do
    [
      app: :form_with_feedback,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FormWithFeedback.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:kino, "~> 0.6.2"}
    ]
  end
end
