defmodule Magento.PhpLinter do
  @moduledoc """
  Minimal PHP Linter.
  """

  # Warning: this is very super slow
  def lint(magento_root) do
    File.cd!(magento_root, &find_bad_files/0)
  end

  defp find_bad_files() do
    "**/*.php"
    |> Path.wildcard()
    |> Enum.filter(&invalid?/1)
  end

  defp invalid?(file) do
    not valid?(file)
  end

  defp valid?(file) do
    line = first_line(file)
    is_nil(line) or Regex.match?(~r/^<\?php/i, line)
  end

  defp first_line(file) do
    file
    |> File.stream!()
    |> Enum.take(1)
    |> List.first()
  end
end
