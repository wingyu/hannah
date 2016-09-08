defmodule TextParserTest do
  use ExUnit.Case

  import Hannah.TextParser, only: [
    sentences: 1,
    words: 1
  ]

  #sentences
  test "breaks up text into a list of downcased sentences" do
    assert sentences("Winter is coming! When, Stark?") == [
      "winter is coming",
      "when, stark"
    ]


    assert sentences("A Lannister always\npays his debts") == [
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





