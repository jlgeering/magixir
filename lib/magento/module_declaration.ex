defmodule Magento.ModuleDeclaration do

  defstruct name: nil, active: false, codePool: nil

  import SweetXml

  def load_folder(folder) do
    folder
    |> Path.join("*.xml")
    |> Path.wildcard()
    |> Enum.sort_by(&sort_key/1)
    |> Enum.flat_map(&load_file/1)
  end

  defp sort_key(file) do
    filename = Path.basename(file)

    # see https://github.com/OpenMage/magento-mirror/blob/magento-1.9/app/code/core/Mage/Core/Model/Config.php#L716
    weight = cond do
      # first comes Mage_All (if there is such a module)
      "Mage_All.xml" == filename ->
        0
      # then all the other Mage_ modules
      String.starts_with?(filename, "Mage_") ->
        1
      # followed by the rest of them
      true ->
        2
    end

    "#{weight}_#{filename}"
  end

  def load_file(file) do
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
