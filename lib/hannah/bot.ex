defmodule Hannah.Bot do
  def response_to(input, data) do
    String.downcase(input)
    |> preprocess(data)
  end

  def greeting(data) do
    random_response("greeting", data)
  end

  def farewell(data) do
    random_response("farewell", data)
  end

  #Private methods

  defp random_response(key, data) do
    responses = data["responses"][key]

    random_index = length(responses)
                    |> :rand.uniform

    Enum.at(responses, random_index - 1)
  end

  #Not sure if this hould this live in TextParser
  #TODO Make more efficient
  defp preprocess(input, data) do
    perform_substitutions(input, data["presubs"])
  end

  defp perform_substitutions(input, []), do: input

  defp perform_substitutions(input, [words | rest_of_presubs]) do
    String.replace(input, Enum.at(words, 0), Enum.at(words, 1))
    |> perform_substitutions(rest_of_presubs)
  end
end
