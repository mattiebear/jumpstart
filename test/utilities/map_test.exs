defmodule Utilities.MapTest do
  use ExUnit.Case

  test "contract!/1 returns a list with the same keys" do
    map = %{"a" => 1, "b" => 2}
    assert Utilities.Map.contract!(map) == [{"a", 1}, {"b", 2}]
  end

  test "contract!/1 returns a list with nested keys in dot notation" do
    map = %{"a" => 1, "b" => %{"c" => 3}}
    assert Utilities.Map.contract!(map) == [{"a", 1}, {"b.c", 3}]
  end

  test "contract!/1 raises an exception if a key is not a string" do
    map = %{:a => 1, "b" => %{"c" => 3}}

    assert_raise ArgumentError, fn ->
      Utilities.Map.contract!(map)
    end
  end
end
