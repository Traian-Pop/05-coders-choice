defmodule TableTest do
  use ExUnit.Case
  doctest Table

  test "creation of spinner" do
    spinner = Table.spinner()
    assert Enum.count(spinner) == 38
  end

  test "values correct" do
    spinner = Table.spinner()
    assert 1 == Enum.count(spinner, &(&1 == {"1", "r"}))
    assert 1 == Enum.count(spinner, &(&1 == {"2", "b"}))
    assert 1 == Enum.count(spinner, &(&1 == {"0", "g"}))
    assert 1 == Enum.count(spinner, &(&1 == {"00", "g"}))
  end

  test "randomness" do
    spinner1 = Table.spin()
    spinner2 = Table.spin()
    spinner3 = Table.spin()
    spinner4 = Table.spin()

    assert spinner1 != spinner2 != spinner3 != spinner4
  end
end
