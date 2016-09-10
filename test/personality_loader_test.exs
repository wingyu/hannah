defmodule PersonalityLoaderTest do
  use ExUnit.Case

  import Hannah.PersonalityLoader, only: [call: 1]

  #call
  test "retrieves personality from a yaml file" do
    assert {:ok, %{"presubs" => _}} = call("test/personalities/test_personality.yaml")
  end

  test "returns an error tuple when file is not found" do
    assert {:error, _} = call("test/personality/wrong_test_personality.yaml")
  end
end


