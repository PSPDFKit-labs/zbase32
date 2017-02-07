defmodule Zbase32.Mixfile do
  use Mix.Project

  def project do
    [app: :zbase32,
     version: "1.0.1",
     name: "ZBase32",
     source_url: "https://github.com/pspdfkit-labs/zbase32",
     docs: [extras: ["README.md"]],
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:earmark, "> 0.0.0", only: :dev},
      {:eqc_ex, "> 0.0.0", only: :test},
      {:ex_doc, "> 0.0.0", only: :dev},
    ]
  end

  defp description do
    "Efficient implementation of z-base-32, Phil Zimmermann's human-oriented base-32 encoding."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["pspdfkit.com"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/pspdfkit-labs/zbase32"}
    ]
  end
end
