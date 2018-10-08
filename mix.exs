defmodule Deppie.Mixfile do
  use Mix.Project

  @version "1.1.2"
  @url_docs "http://hexdocs.pm/deppie"
  @url_github "https://github.com/whitfin/deppie"

  def project do
    [
      app: :deppie,
      name: "Deppie",
      description: "Elixir's coolest deprecation logger",
      package: %{
        files: [
          "lib",
          "mix.exs",
          "LICENSE",
          "README.md"
        ],
        licenses: [ "MIT" ],
        links: %{
          "Docs" => @url_docs,
          "GitHub" => @url_github
        },
        maintainers: [ "Isaac Whitfield" ]
      },
      version: @version,
      elixir: "~> 1.1",
      deps: deps(),
      docs: [
        extras: [ "README.md" ],
        source_ref: "v#{@version}",
        source_url: @url_github
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # Production dependencies required
      { :global_flags, "~> 1.0" },
      # Development only dependencies, not shipped to production
      { :ex_doc,  "~> 0.16", optional: true, only: [ :docs ] }
    ]
  end
end
