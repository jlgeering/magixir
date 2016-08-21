defmodule Magento.PhpLinterTest do
  use ExUnit.Case
  doctest Magento.Version

  @fixtures Path.join(__DIR__, "../fixtures")

  test "no warnings for valid files" do
    files = Magento.PhpLinter.find_bad_files(Path.join(@fixtures, "magento"))
    assert files == []
  end

  test "find all files that do not start with <?php" do
    files = Magento.PhpLinter.find_bad_files(Path.join(@fixtures, "php_linter"))
    expected = MapSet.new [
      "space.php",
      "a/space.php",
      "newline.php",
    ]
    assert MapSet.new(files) == expected
  end

end
