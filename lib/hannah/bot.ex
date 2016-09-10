defmodule Hannah.Bot do
  def response_to(input, personality) do
    String.downcase(input)
    |> preprocess(personality)
    |> break_into_sentences
    |> most_relevant_sentence(personality)
    |> respond(personality)
  end

  def greeting(personality), do: Hannah.ResponseGenerator.greeting(personality)
  def farewell(personality), do: Hannah.ResponseGenerator.farewell(personality)

  #PRIVATE#######################

  defp respond(sentence, personality) do
    Hannah.ResponseGenerator.respond(sentence, personality)
  end

  defp preprocess(input, personality) do
    #TODO Make more efficient--- change YAML personality structrue
    perform_substitutions(input, personality["presubs"])
  end

  defp perform_substitutions(input, []), do: input
  defp perform_substitutions(input, [words | rest_of_presubs]) do
    String.replace(input, Enum.at(words, 0), Enum.at(words, 1))
    |> perform_substitutions(rest_of_presubs)
  end

  defp break_into_sentences(input), do: Hannah.TextParser.sentences(input)

  defp most_relevant_sentence(sentences, personality) do
    #TODO include phrases like "I hate/ I like into hot_words...currently
    #doesn't work since sentences are broken into words in WordPlay
    #-Don't break into words first?
    hot_words = Map.keys(personality["responses"])
                  |> Enum.filter(&(!Regex.match?(~r/\s/, &1)))

    Hannah.WordPlay.most_relevant_sentence(sentences, hot_words)
  end
end
