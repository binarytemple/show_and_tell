defmodule ShowAndTellTest do
  use ExUnit.Case
  doctest ShowAndTell

  test "greets the world" do
    assert ShowAndTell.hello() == :world
  end
end
