defmodule Deppie.Mixfile do
  use Mix.Project

  @url_docs "http://hexdocs.pm/deppie"
  @url_github "https://github.com/zackehh/deppie"

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
      version: "1.1.0",
      elixir: "~> 1.1",
      deps: deps(),
      docs: [
        extras: [ "README.md" ],
        source_ref: "master",
        source_url: @url_github
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger], mod: {Deppie.Application, []}]
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
      { :earmark, "~> 1.0",  optional: true, only: [ :dev, :test ] },
      { :ex_doc,  "~> 0.14", optional: true, only: [ :dev, :test ] }
    ]
  end
end
