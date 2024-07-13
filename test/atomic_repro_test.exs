defmodule AtomicReproTest do
  use ExUnit.Case
  doctest AtomicRepro

  test "greets the world" do
    assert AtomicRepro.hello() == :world
  end
end
