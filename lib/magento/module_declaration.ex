defmodule Magento.ModuleDeclaration do

  defstruct name: nil, active: false

  import SweetXml

  def load(file) do
    File.read!(file) |> xpath(~x"//config/modules/*"l)
  end

end
