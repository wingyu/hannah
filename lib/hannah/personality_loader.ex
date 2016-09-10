defmodule Hannah.PersonalityLoader do
  def call(path \\ "lib/personalities/default_personality.yaml") do
    yaml = File.cwd!
            |> Path.join(path)
            |> YamlElixir.read_from_file

    {:ok, yaml}
  catch
    {_, error} -> {:error, error}
  end
end


