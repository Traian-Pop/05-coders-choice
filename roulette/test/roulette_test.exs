defmodule RouletteTest do
  use ExUnit.Case
  doctest Roulette

  test "new spinner" do
    spinner = Roulette.Game.new_game()
    assert elem(spinner, 0).game_state == :init
    assert elem(spinner, 0).player_val == []
    assert elem(spinner, 0).table_val == []
  end

  test "betting succesfully" do
    spinner = Roulette.Game.new_game()
    result = Roulette.Game.spin("red", elem(spinner, 0))
    value = elem(result,0).table_val
    if elem(value, 1) == "r" do
      assert elem(result,0).game_state == true
    else
      assert elem(result,0).game_state != true
    end
  end

  test "failing the betting" do
    spinner = Roulette.Game.new_game()
    result = Roulette.Game.spin("red", elem(spinner, 0))
    value = elem(result,0).table_val
    if elem(value, 1) == "b" do
      assert elem(result,0).game_state == false
    else
      assert elem(result,0).game_state != false
    end
  end

  test "betting succesfully on number" do
    spinner = Roulette.Game.new_game()
    result = Roulette.Game.spin(30, elem(spinner, 0))
    value = elem(result,0).table_val
    if elem(value, 0) == 30 do
      assert elem(result,0).game_state == true
    else
      assert elem(result,0).game_state != true
    end
  end
end
