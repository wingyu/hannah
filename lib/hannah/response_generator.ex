defmodule Hannah.ResponseGenerator do

  def possible_responses(sentence, data) do
    Map.keys(data["responses"])
    |> add_non_generic_responses(sentence,data)
    |> add_confused_responses(data)
    |> List.flatten
  end

  def greeting(data) do
    random_default_message("greeting", data)
  end

  def farewell(data) do
    random_default_message("farewell", data)
  end

  #PRIVATE#######################

  defp random_default_message(key, data) do
    responses = data["default"][key]

    random_index = length(responses)
                    |> :rand.uniform

    Enum.at(responses, random_index - 1)
  end


  defp add_non_generic_responses([], _sentence,_data), do: []
  defp add_non_generic_responses(keys, sentence, data) do
    Enum.reduce(keys, [], fn(pattern, total_responses) ->
      #TODO use regex to wrap cleaned_pattern in #contains?
      responses = data["responses"][pattern]
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

  defp add_confused_responses([], data), do: data["default"]["confused"]
  defp add_confused_responses(responses, _data), do: responses
end