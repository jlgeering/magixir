defmodule Magento.ModuleDeclarationTest do
  use ExUnit.Case
  doctest Magento.ModuleDeclaration

  alias Magento.ModuleDeclaration, as: Mut

  @fixtures Path.join(__DIR__, "../fixtures")

  test "load non existant file" do
    assert %File.Error{} = catch_error(Mut.load(Path.join(@fixtures, "not_found.xml")))
  end

  test "load single module" do
    modules = Mut.load(Path.join(@fixtures, "magento_root/app/etc/modules/Mage_Api.xml"))
    assert Enum.count(modules) == 1
  end

  test "load multiple modules" do
    modules = Mut.load(Path.join(@fixtures, "magento_root/app/etc/modules/Mage_All.xml"))
    assert Enum.count(modules) == 47
  end


end
