defmodule Hannah.Bot do
  def response_to(input, data) do
    String.downcase(input)
    |> preprocess(data)
    |> break_into_sentences
    |> most_relevant_sentence(data)
    |> possible_responses(data)
    |> Enum.random
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
    #TODO Make more efficient--- change YAML data structrue
    perform_substitutions(input, data["presubs"])
  end

  defp perform_substitutions(input, []), do: input

  defp perform_substitutions(input, [words | rest_of_presubs]) do
    String.replace(input, Enum.at(words, 0), Enum.at(words, 1))
    |> perform_substitutions(rest_of_presubs)
  end

  defp most_relevant_sentence(sentences, data) do
    #TODO include phrases like "I hate/ I like into hot_words...currently
    #doesn't work since sentences are broken into words in WordPlay
    #-Don't break into words first?
    hot_words = Map.keys(data["responses"])
                  |> Enum.filter(&(!Regex.match?(~r/\s/, &1)))

    Hannah.WordPlay.most_relevant_sentence(sentences, hot_words)
  end

  defp possible_responses(sentence, data) do
    Map.keys(data["responses"])
    |> add_non_generic_responses(sentence,data)
    |> add_confused_responses(data)
    |> List.flatten
  end

  defp add_non_generic_responses([], _sentence,_data), do: []
  defp add_non_generic_responses(keys, sentence, data) do
    Enum.reduce(keys, [], fn(pattern, acc) ->
      #TODO use regex to wrap y in #contains? and improve var name
      responses = data["responses"][pattern]
      cleaned_pattern = String.replace(pattern, "*", "")

      if String.contains?(sentence, cleaned_pattern) do
        if String.contains?(pattern, "*") do
          switched_placeholder = String.replace(sentence, ~r/^.*#{pattern}\s+/, "")
                              |> Hannah.WordPlay.switch_pronouns

          responses = Enum.map(responses, &(String.replace(&1, "*", switched_placeholder)))
          List.insert_at(acc, 0, responses)
        else
          List.insert_at(acc, 0, responses)
        end
      else
        acc
      end
    end)
  end

  defp add_confused_responses([], data), do: data["default"]["confused"]
  defp add_confused_responses(responses, _data), do: responses
end
