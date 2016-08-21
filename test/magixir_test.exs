defmodule MagixirTest do
  use ExUnit.Case
  doctest Magixir

  @fixtures Path.join(__DIR__, "fixtures")

  # Magento Community Edition
  @magento_root_1_0      Path.join(@fixtures, "magento_1.0")
  @magento_root_1_3_3_0  Path.join(@fixtures, "magento_1.3.3.0")
  @magento_root_1_4_0_0  Path.join(@fixtures, "magento_1.4.0.0")
  @magento_root_1_7_0_2  Path.join(@fixtures, "magento_1.7.0.2")
  # Magento Enterprise Edition
  @magento_root_1_13_0_0 Path.join(@fixtures, "magento_1.13.0.0")

  test "the truth" do
    # IO.puts Path.absname(@fixtures)
    # IO.puts Path.absname(@magento_root_1_0)
    assert 1 + 1 == 2
  end

  test "returns nil when not found" do
    {status, _} = Magento.Version.read_from(Path.join(__DIR__, "nope"))
    assert status == :error
  end
  test "reads version 1.0" do
    {:ok, version} = Magento.Version.read_from(@magento_root_1_0)
    assert version == [1,0]
  end
  test "reads version 1.3.3.0" do
      {:ok, version} = Magento.Version.read_from(@magento_root_1_3_3_0)
      assert version == [1,3,3,0]
  end
  test "reads version 1.4.0.0" do
    {:ok, version} = Magento.Version.read_from(@magento_root_1_4_0_0)
    assert version == [1,4,0,0]
  end
  test "reads version 1.7.0.2" do
    {:ok, version} = Magento.Version.read_from(@magento_root_1_7_0_2)
    assert version == [1,7,0,2]
  end
  test "reads version 1.13.0.0" do
    {:ok, version} = Magento.Version.read_from(@magento_root_1_13_0_0)
    assert version == [1,13,0,0]
  end
end
