defmodule Magento.ModuleDeclarationTest do
  use ExUnit.Case
  doctest Magento.ModuleDeclaration

  alias Magento.ModuleDeclaration, as: Mut

  @fixtures Path.join(__DIR__, "../fixtures")

  test "load non existant file" do
    assert %File.Error{} = catch_error(Mut.load_file(Path.join(@fixtures, "not_found.xml")))
  end

  test "load single module (from 1 file)" do
    file = Path.join(@fixtures, "magento_root/app/etc/modules/Mage_Api.xml")
    modules = Mut.load_file(file)
    assert Enum.count(modules) == 1
    module = List.first(modules)
    assert %Mut{
      name: :Mage_Api,
      active: true,
      codePool: "core",
      file: file
    } = module
  end

  test "load multiple modules (from 1 file)" do
    modules = Mut.load_file(Path.join(@fixtures, "magento_root/app/etc/modules/Mage_All.xml"))
    assert Enum.count(modules) == 47
  end

  test "load all module declations (from 1 folder)" do
    modules = Mut.load_folder(Path.join(@fixtures, "module_declarations/load_all"))
    assert Enum.count(modules) == 5
  end

  test "sort module declarations (the magento way)" do
    modules = Mut.load_folder(Path.join(@fixtures, "module_declarations/sorted"))
    assert [:m1, :m2, :m3, :m4, :m5, :m6] == Enum.map(modules, &(Map.fetch!(&1, :name)))
  end

  test "find the module declarations given magento_root" do
    modules = Mut.load(Path.join(@fixtures, "magento_root"))
    assert Enum.count(modules) > 0
  end

  test "module declarations file relative to magento_root" do
    file = @fixtures
      |> Path.join("magento_root")
      |> Mut.load()
      |> List.first()
      |> Map.fetch!(:file)
    assert "app/etc/modules/Mage_All.xml" == file
  end

end
