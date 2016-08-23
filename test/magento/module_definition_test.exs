defmodule Magento.ModuleDefinitionTest do
  use ExUnit.Case
  doctest Magento.ModuleDefinition

  alias Magento.ModuleDefinition, as: Mut

  @fixtures Path.join(__DIR__, "../fixtures")

  test "parse non existant file" do
    module_definition = Mut.parse_file(Path.join(@fixtures, "not_found.xml"))
    assert module_definition == nil
  end

end
