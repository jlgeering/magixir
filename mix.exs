defmodule Magixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :magixir,
      version: "0.1.2",
      elixir: "~> 1.4",
      description: description(),
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs
      name: "Magixir",
      # source_url: "https://github.com/jlgeering/magixir/",
      docs: [
        extras: [
          "CHANGELOG.md",
        ]
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

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
        "GitHub" => "https://github.com/jlgeering/magixir",
      },
    ]
  end
end
