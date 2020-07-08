defmodule ShowAndTell.MixProject do
  use Mix.Project

  def project do
    [
      app: :show_and_tell,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:packmatic, git: "https://github.com/evadne/packmatic.git", branch: "develop"},
      {:expat, "~> 1.0.5"},
      {:elixpath, "~> 0.1.0"},
      {:morphix, "~> 0.8.0"}
    ]
  end
end
