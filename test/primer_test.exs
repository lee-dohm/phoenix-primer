defmodule PrimerTest do
  use ExUnit.Case
  doctest Primer

  test "greets the world" do
    assert Primer.hello() == :world
  end
end
