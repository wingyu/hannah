defmodule Hannah.ResponseGenerator do

  def possible_responses(sentence, personality) do
    Map.keys(personality["responses"])
    |> add_non_generic_responses(sentence, personality)
    |> add_confused_responses(personality)
    |> List.flatten
  end

  def greeting(personality) do
    random_default_message("greeting", personality)
  end

  def farewell(personality) do
    random_default_message("farewell", personality)
  end

  #PRIVATE#######################

  defp random_default_message(key, personality) do
    responses = personality["default"][key]

    random_index = length(responses)
                    |> :rand.uniform

    Enum.at(responses, random_index - 1)
  end


  defp add_non_generic_responses([], _sentence,_personality), do: []
  defp add_non_generic_responses(keys, sentence, personality) do
    Enum.reduce(keys, [], fn(pattern, total_responses) ->
      #TODO use regex to wrap cleaned_pattern in #contains? and CLEANUP
      responses = personality["responses"][pattern]
      cleaned_pattern = String.replace(pattern, "*", "")

      if String.contains?(sentence, cleaned_pattern) do
        if String.contains?(pattern, "*") do
          switched_placeholder = String.replace(sentence, ~r/^.*#{pattern}\s+/, "")
                              |> Hannah.WordPlay.switch_pronouns

          responses = Enum.map(responses, &(String.replace(&1, "*", switched_placeholder)))
          List.insert_at(total_responses, 0, responses)
        else
          List.insert_at(total_responses, 0, responses)
        end
      else
        total_responses
      end
    end)
  end

  defp add_confused_responses([], personality), do: personality["default"]["confused"]
  defp add_confused_responses(responses, _personality), do: responses
end
