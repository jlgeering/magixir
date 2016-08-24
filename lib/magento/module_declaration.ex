defmodule Magento.ModuleDeclaration do

  defstruct name: nil, active: false, codePool: nil

  import SweetXml

  def load(file) do
    File.read!(file) |> xpath(~x"//config/modules/*"l) |> Enum.map(&parse_declaration/1)
  end

  def parse_declaration(e) do
    name = xmlElement(e, :name)
    %Magento.ModuleDeclaration{
      name: name,
      active: true,
      codePool: "core"
    }
  end

end
