defmodule Zbase32.Mixfile do
  use Mix.Project

  @source_url "https://github.com/pspdfkit-labs/zbase32"
  @version "2.0.0"

  def project do
    [
      app: :zbase32,
      version: @version,
      name: "ZBase32",
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:earmark, "> 0.0.0", only: :dev},
      {:eqc_ex, "> 0.0.0", only: :test},
      {:ex_doc, "> 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      description: "Efficient implementation of z-base-32, Phil Zimmermann's "
        <> "human-oriented base-32 encoding.",
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["PSPDFKit"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "PSPDFKit" => "https://pspdfkit.com"
      }
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "EQC_CI_LICENCE.md": [title: "EQC CI License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
