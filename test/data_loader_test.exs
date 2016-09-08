defmodule DataLoaderTest do
  use ExUnit.Case

  import Hannah.DataLoader, only: [call: 1]

  #call
  test "retrieves data from a yaml file" do
    assert {:ok, %{"presubs" => _}} = call("test/data/test_data.yaml")
  end

  test "returns an error tuple when file is not found" do
    assert {:error, _} = call("test/data/wrong_test_data.yaml")
  end
end


