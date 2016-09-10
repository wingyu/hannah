defmodule ResponseGeneratorTest do
  use ExUnit.Case

  import Hannah.ResponseGenerator, only: [
    greeting: 1,
    farewell: 1,
    respond: 2,
  ]

  #greet
  test "greets the user" do
    {:ok, personality} = \
      Hannah.PersonalityLoader.call("test/personalities/test_personality.yaml")

    greetings = personality["default"]["greeting"]

    assert(Enum.member?(greetings, greeting(personality))) == true
  end

  #farewell
  test "says goodbye to the user" do
    {:ok, personality} = \
      Hannah.PersonalityLoader.call("test/personalities/test_personality.yaml")

    farewells = personality["default"]["farewell"]

    assert(Enum.member?(farewells, farewell(personality))) == true
  end

  #respond
  test "responds with confusion if no response for input" do
    {:ok, personality} = \
      Hannah.PersonalityLoader.call("test/personalities/test_personality.yaml")

    confused_responses = personality["default"]["confused"]

    assert(Enum.member?(confused_responses, respond("yolo", personality))) == true
  end

  test "responds to input with words stored in personality" do
    {:ok, personality} = \
      Hannah.PersonalityLoader.call("test/personalities/test_personality.yaml")

    responses = personality["responses"]["hello"]

    assert(Enum.member?(
      responses, respond("hello!", personality)
    )) == true
  end

  test "responds to input with phrases stored in personality" do
    {:ok, personality} = \
      Hannah.PersonalityLoader.call("test/personalities/test_personality.yaml")

    responses = personality["responses"]["i like *"]

    assert(respond("i like apples", personality)) == "Why do you like apples?"
  end
end
