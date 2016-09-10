defmodule Hannah.Bot do
  def response_to(input, data) do
    String.downcase(input)
    |> preprocess(data)
    |> break_into_sentences
    |> most_relevant_sentence(data)
    #|> possible_responses(data)
  end

  def greeting(data) do
    random_default_message("greeting", data)
  end

  def farewell(data) do
    random_default_message("farewell", data)
  end

  #Private methods

  defp break_into_sentences(input), do: Hannah.TextParser.sentences(input)

  defp random_default_message(key, data) do
    responses = data["default"][key]

    random_index = length(responses)
                    |> :rand.uniform

    Enum.at(responses, random_index - 1)
  end

  defp preprocess(input, data) do
    #TODO Make more efficient
    perform_substitutions(input, data["presubs"])
  end

  defp perform_substitutions(input, []), do: input

  defp perform_substitutions(input, [words | rest_of_presubs]) do
    String.replace(input, Enum.at(words, 0), Enum.at(words, 1))
    |> perform_substitutions(rest_of_presubs)
  end

  defp most_relevant_sentence(sentences, data) do
    hot_words = Map.keys(data["responses"])
                  |> Enum.filter(&(!Regex.match?(~r/\s/, &1)))

    Hannah.WordPlay.most_relevant_sentence(sentences, hot_words)
  end

  defp possible_responses(sentence, data) do
    #get keys
    #patterns = Map.keys(data["responses"])

  end
end
