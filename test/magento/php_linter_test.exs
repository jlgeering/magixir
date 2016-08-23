defmodule Magento.PhpLinterTest do
  use ExUnit.Case
  doctest Magento.PhpLinter

  alias Magento.PhpLinter, as: Mut

  @fixtures Path.join(__DIR__, "../fixtures")

  test "no warnings for valid files" do
    files = Mut.lint(Path.join(@fixtures, "magento"))
    assert files == []
  end

  test "find all files that do not start with <?php" do
    files = Mut.lint(Path.join(@fixtures, "php_linter"))
    expected = MapSet.new [
      "space.php",
      "a/space.php",
      "newline.php",
    ]
    assert MapSet.new(files) == expected
  end

end
