defmodule Hannah.TextParser do
  def sentences(text) do
    String.replace(text, ~r/\n/, " ")
    |> String.split(~r/(\?|\!|\.)\s*/, trim: true)
  end

  def words(sentence), do: String.split(sentence, ~r/\s|,/, trim: true)
end
