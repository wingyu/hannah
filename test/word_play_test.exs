defmodule WordPlayTest do
  use ExUnit.Case

  import Hannah.WordPlay, only: [
    most_relevant_sentence: 2,
    switch_pronouns: 1
  ]

  #most relevant sentence
  test "returns the sentence with the most relevant words" do
    assert most_relevant_sentence([
      "the best around",
      "the worst around",
      "the best best around",
      "best yolo in the best world"
    ], ["best", "around"]) == "the best best around"

    assert most_relevant_sentence([
      "the best around",
      "the worst around",
    ], ["middle"]) == "the worst around" #better to have first sentence?

  end

  #switch pronouns
  test "it switches the pronouns" do
    assert switch_pronouns("i am a robot") == "you are a robot"
    assert switch_pronouns("you are a person") == "i am a person"
    assert switch_pronouns("i love you") == "you love me"
    assert switch_pronouns("you gave me life") == "i gave you life"
    assert switch_pronouns("i am not what you are") == "you are not what i am"
    assert switch_pronouns("my cat is awesome") == "your cat is awesome"
    assert switch_pronouns("yes, i rule") == "yes, you rule"
    assert switch_pronouns("why do i eat") == "why do you eat"
  end
end


