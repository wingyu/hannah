defmodule Hannah.ResponseGenerator do

  def call(sentence, personality) do
    possible_responses(sentence, personality)
    |> Enum.random
  end

  defp possible_responses(sentence, personality) do
    Map.keys(personality["responses"])
    |> add_responses(sentence, personality)
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


  defp add_responses([], _sentence,_personality), do: []
  defp add_responses(keys, sentence, personality) do
    Enum.reduce(keys, [], fn(pattern, total_responses) ->
      responses = personality["responses"][pattern]
      cleaned_pattern = String.replace(pattern, "*", "")

      if String.match?(sentence, ~r/\b#{cleaned_pattern}\b/) do
        find_responses(sentence, pattern, responses, total_responses)
      else
        total_responses
      end
    end)
  end

  def find_responses(sentence, pattern, responses, total_responses) do
    if String.contains?(pattern, "*") do
      switched_placeholder = String.replace(sentence, ~r/^.*#{pattern}\s+/, "")
                              |> Hannah.WordPlay.switch_pronouns

      responses = Enum.map(responses, &(String.replace(&1, "*", switched_placeholder)))
      List.insert_at(total_responses, 0, responses)
    else
      List.insert_at(total_responses, 0, responses)
    end
  end

  defp add_confused_responses([], personality), do: personality["default"]["confused"]
  defp add_confused_responses(responses, _personality), do: responses
end
