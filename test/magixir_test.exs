defmodule MagixirTest do
  use ExUnit.Case
  doctest Magixir

  @fixtures Path.join(__DIR__, "fixtures")

  test "the truth" do
    assert 1 + 1 == 2
  end

end
