defmodule Hannah.Bot do
  def response_to(input, data) do
    String.downcase(input)
    |> preprocess(data)
    |> break_into_sentences
    |> most_relevant_sentence(data)
    |> possible_responses(data)
    |> Enum.random
  end

  def greeting(data), do: Hannah.ResponseGenerator.greeting(data)
  def farewell(data), do: Hannah.ResponseGenerator.farewell(data)

  #PRIVATE#######################

  defp preprocess(input, data) do
    #TODO Make more efficient--- change YAML data structrue
    perform_substitutions(input, data["presubs"])
  end

  defp perform_substitutions(input, []), do: input
  defp perform_substitutions(input, [words | rest_of_presubs]) do
    String.replace(input, Enum.at(words, 0), Enum.at(words, 1))
    |> perform_substitutions(rest_of_presubs)
  end

  defp break_into_sentences(input), do: Hannah.TextParser.sentences(input)

  defp most_relevant_sentence(sentences, data) do
    #TODO include phrases like "I hate/ I like into hot_words...currently
    #doesn't work since sentences are broken into words in WordPlay
    #-Don't break into words first?
    hot_words = Map.keys(data["responses"])
                  |> Enum.filter(&(!Regex.match?(~r/\s/, &1)))

    Hannah.WordPlay.most_relevant_sentence(sentences, hot_words)
  end

  defp possible_responses(sentence, data) do
    Hannah.ResponseGenerator.possible_responses(sentence, data)
  end
end
