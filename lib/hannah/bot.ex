defmodule Hannah.Bot do
  def greeting(data) do
    random_response("greeting", data)
  end

  def farewell(data) do
    random_response("farewell", data)
  end
  defp random_response(key, data) do
    responses = data["responses"][key]

    random_index = length(responses)
    |> :rand.uniform

    Enum.at(responses, random_index - 1)
  end
end
