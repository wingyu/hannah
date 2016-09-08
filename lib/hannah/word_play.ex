defmodule Hannah.WordPlay do
  def switch_pronouns(text) do
    pronouns = ~r/\b(i am|me|you are|you |you|my|your|i)\b/
    Regex.replace(pronouns, text,
    fn x ->
      case x do
        "i am" ->
          "you are"
        "you are" ->
          "i am"
        "your" ->
          "my"
        "my" ->
          "your"
        "i" ->
          "you"
        "you " ->
          "i "
        "me" ->
          "you"
        "you" ->
          "me"
      end
    end
    )
  end

  def most_relevant_sentence(sentences, hot_words) do
    Enum.sort(sentences,
      &(relevance_score(&1, hot_words) > relevance_score(&2, hot_words)))
    |> List.first
  end

  defp relevance_score(sentence, hot_words) do
    Hannah.TextParser.words(sentence)
    |> Enum.count(&(relevant_sentence?(&1, hot_words)))
  end

  defp relevant_sentence?(sentence, hot_words) do
    String.contains?(sentence, hot_words)
  end
end




