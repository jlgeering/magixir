defmodule Magento.ModuleConfiguration do
  @moduledoc """
  Provides a module-configuration struct and related loading and processing functions.
  """

  defstruct name: nil, version: nil, file: nil

  import SweetXml

  def load_file(file) do
    file
    |> File.read!()
    |> xpath(~x"//config/modules/*"l)
    |> Enum.map(&(parse_declaration(&1, file)))
  end

  defp parse_declaration(e, file) do
    %Magento.ModuleConfiguration{
      name:
        xmlElement(e, :name),
      version:
        xpath(e,~x"./version/text()"s),
      file:
        file
    }
  end

  # ======= processing =======

end
