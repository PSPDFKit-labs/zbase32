defmodule Zbase32.Mixfile do
  use Mix.Project

  def project do
    [app: :zbase32,
     version: "1.0.0",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:eqc_ex, "~> 1.2.3", only: :test}
    ]
  end

  defp description do
    """
    Efficient implementation of z-base-32, Phil Zimmermann's human-oriented base-32 encoding.

    z-base-32 is a Base32 encoding designed to be easier for human use and more compact. It includes
    1, 8 and 9 but excludes l, v and 2. It also permutes the alphabet so that the easier characters
    are the ones that occur more frequently. It compactly encodes bitstrings whose length in bits is
    not a multiple of 8, and omits trailing padding characters. z-base-32 was used in Mnet open
    source project, and is currently used in Phil Zimmermann's ZRTP protocol, and in the Tahoe-LAFS
    open source project.
    """
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
