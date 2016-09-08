defmodule TextParserTest do
  use ExUnit.Case

  import Hannah.TextParser, only: [
    sentences: 1,
    words: 1
  ]

  #sentences
  test "breaks up text into a list of sentences" do
    assert sentences("winter is coming! when, stark?") == [
      "winter is coming",
      "when, stark"
    ]


    assert sentences("a lannister always\npays his debts") == [
      "a lannister always pays his debts"
    ]
  end

  #words
  test "breaks up a sentence into a list of words" do
    assert words("Hello, I'm dope words'") == [
      "Hello",
      "I'm",
      "dope",
      "words'"
    ]
  end
end
