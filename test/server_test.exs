defmodule ServerTest do
  use ExUnit.Case, async: true

  import Hannah.Server, only: [
    start_link: 1,
    converse: 1,
    farewell: 0
  ]

  test "spawns a bot to talk to" do
    {:ok, personality} = \
      Hannah.PersonalityLoader.call("test/personalities/test_personality.yaml")

    responses = personality["responses"]["hello"]

    assert(Enum.member?(
      responses, converse("hello!")
    )) == true
  end

  #Hmmm....Need to make this more explicit, just asserting :ok is not enough
  test "closes the bot" do
    assert farewell == :ok
  end
end
