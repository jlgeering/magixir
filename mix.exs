defmodule Magixir.Mixfile do
  use Mix.Project

  def project do
    [app: :magixir,
     version: "0.1.1",
     elixir: "~> 1.2",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
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
      {:credo, "~> 0.4", only: [:dev, :test]},
      {:ex_doc, "~> 0.14.0", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:sweet_xml, "~> 0.6.1"},
    ]
  end

  defp description do
    """
    Magento Elixir Tools.
    """
  end

  defp package do
    [
      licenses:    ["MIT"],
      maintainers: ["Jean-Luc Geering"],
      links:       %{
        "Changelog" => "https://github.com/jlgeering/magixir/blob/master/CHANGELOG.md",
        "GitHub" => "https://github.com/jlgeering/magixir"
      }
    ]
  end
end
