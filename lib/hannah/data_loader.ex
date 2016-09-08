defmodule Hannah.DataLoader do
  def call(path \\ "lib/data/bot_data.yaml") do
    yaml = File.cwd!
            |> Path.join(path)
            |> YamlElixir.read_from_file

    {:ok, yaml}
  catch
    {_, error} -> {:error, error}
  end
end


