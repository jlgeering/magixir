defmodule Magento.ModuleDeclaration do

  defstruct name: nil, active: false

  import SweetXml

  def load(file) do
    File.read!(file) |> xpath(~x"//config/modules/*"l) |> Enum.map(&parse_declaration/1)
  end

  def parse_declaration(e) do
    %{ name: xmlElement(e, :name) }
  end

end
