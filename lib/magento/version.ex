defmodule Magento.Version do

  def read_from(magento_root) do
    mage_php = Path.join(magento_root, "app/Mage.php")
    # TODO encoding?
    {status, code} = File.read mage_php
    if :ok != status do
      {status, code}
    else
      new_pattern = ~r/ public static function getVersionInfo\(\)\R\s+{\R\s+return array\(\R\s+'major'\s+=> '(\d+)',\R\s+'minor'\s+=> '(\d+)',\R\s+'revision'\s+=> '(\d+)',\R\s+'patch'\s+=> '(\d+)',/
      old_pattern = ~r/ public static function getVersion\(\)\R\s+{\R\s+return '(\d+)\.(\d+)\.?(\d+)?\.?(\d+)?';/
      if Regex.match?(new_pattern, code) do
        [match | v] = Regex.run(new_pattern, code)
        v = Enum.map(v, &(String.to_integer(&1)))
        {:ok, v}
      else
        [match | v] = Regex.run(old_pattern, code)
        v = Enum.map(v, &(String.to_integer(&1)))
        {:ok, v}
      end
    end
  end
end
