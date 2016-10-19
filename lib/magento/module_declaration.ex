defmodule Magento.ModuleDeclaration do
  @moduledoc """
  Provides a module-declaration struct and related loading and processing functions.
  """

  defstruct name: nil, active: false, codePool: nil, dependencies: nil, file: nil

  import SweetXml

  def load(magento_root) do
    magento_root
    |> Path.join("app/etc/modules")
    |> load_folder()
    |> Enum.map(&(%{&1 | file: Path.relative_to(&1.file, magento_root)}))
  end

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
    |> Enum.map(&(parse_declaration(&1, file)))
  end

  defp parse_declaration(e, file) do
    %Magento.ModuleDeclaration{
      name:
        xmlElement(e, :name),
      active:
        ("true" == xpath(e,~x"./active/text()"s)),
      codePool:
        xpath(e,~x"./codePool/text()"s),
      dependencies:
        e |> xpath(~x"./depends/*"l) |> Enum.map(&(xmlElement(&1, :name))),
      file:
        file
    }
  end

end
