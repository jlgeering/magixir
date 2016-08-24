defmodule Magento.ModuleDeclarationTest do
  use ExUnit.Case
  doctest Magento.ModuleDeclaration

  alias Magento.ModuleDeclaration, as: Mut

  @fixtures Path.join(__DIR__, "../fixtures")

  test "load non existant file" do
    module_definition = Mut.load(Path.join(@fixtures, "not_found.xml"))
    assert module_definition == nil
  end

end
