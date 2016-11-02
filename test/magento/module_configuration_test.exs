defmodule Magento.ModuleConfigurationTest do
  use ExUnit.Case
  doctest Magento.ModuleConfiguration

  alias Magento.ModuleConfiguration, as: Mut

  @fixtures Path.join(__DIR__, "../fixtures")

  test "load non existant file" do
    assert %File.Error{} = catch_error(Mut.load_file(Path.join(@fixtures, "not_found.xml")))
  end

  test "load single module (from 1 file)" do
    file = Path.join(@fixtures, "magento_root/app/code/core/Mage/A/etc/config.xml")
    modules = Mut.load_file(file)
    assert Enum.count(modules) == 1
    module = List.first(modules)
    assert %Mut{
      name: :Mage_A,
      version: "1.2.3",
      file: ^file
    } = module
  end

end
