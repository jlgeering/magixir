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
      dependencies: [:Mage_Core],
      file: ^file
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

  test "sort preserves order when no dependencies" do
    unsorted = [
      %Mut{name: :A, dependencies: []},
      %Mut{name: :B, dependencies: []}
    ]

    sorted = unsorted
      |> Mut.sort()
      |> Enum.map(&(&1.name))

    assert [:A, :B] == sorted
  end

  test "sort with 1 dependency" do
    unsorted = [
      %Mut{name: :A, dependencies: [:B]},
      %Mut{name: :B, dependencies: []}
    ]

    sorted = unsorted
      |> Mut.sort()
      |> Enum.map(&(&1.name))

    assert [:B, :A] == sorted
  end

  test "sort with more dependencies" do
    unsorted = [
      %Mut{name: :A, dependencies: [:B, :C]},
      %Mut{name: :B, dependencies: []},
      %Mut{name: :C, dependencies: []}
    ]

    sorted = unsorted
      |> Mut.sort()
      |> Enum.map(&(&1.name))

    assert [:B, :C, :A] == sorted
  end

  test "sort with transitive dependencies" do
    unsorted = [
      %Mut{name: :A, dependencies: [:C]},
      %Mut{name: :B, dependencies: []},
      %Mut{name: :C, dependencies: []},
      %Mut{name: :D, dependencies: []}
    ]

    sorted = unsorted
      |> Mut.sort()
      |> Enum.map(&(&1.name))

    assert sorted == [:B, :C, :A, :D]
  end

end
