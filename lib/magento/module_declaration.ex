defmodule Magento.ModuleDeclaration do

  defstruct name: nil, active: false, codePool: nil

  import SweetXml

  def load(file) do
    file
    |> File.read!()
    |> xpath(~x"//config/modules/*"l)
    |> Enum.map(&parse_declaration/1)
  end

  def parse_declaration(e) do
    name = xmlElement(e, :name)
    active = ("true" == xpath(e,~x"./active/text()"s))
    %Magento.ModuleDeclaration{
      name: name,
      active: active,
      codePool: xpath(e,~x"./codePool/text()"s)
    }
  end

end
