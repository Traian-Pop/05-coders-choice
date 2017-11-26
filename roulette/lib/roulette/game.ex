defmodule Roulette.Game do

  require Integer

  # New game method
  def new_game() do
    %Roulette.State{}
    |> return_check
  end

  # State
  def check(game) do
  %{
    game_state: game.game_state,
    player_val: game.player_val,
    table_val: game.table_val
  }
  end

  def spin(bet, game) do
    game = %{ game | player_val: bet }
    Table.spin()
    |> spin_helper(game)
    |> return_check
  end


  ######## Private Methods ########
  
  # Returns game state
  defp return_check(game) do
    { game, check(game) }
  end

  # Red bet
  defp spin_helper(val, game = %{ player_val: "red" }) do
    result = if elem(val, 1) == "r" do true else false end
    game
    |> Map.put(:game_state, result)
    |> Map.put(:table_val, val)
  end
 
  # Black bet
  defp spin_helper(val, game = %{ player_val: "black" }) do
    result = if elem(val, 1) == "b" do true else false end
    game
    |> Map.put(:game_state, result)
    |> Map.put(:table_val, val)
  end
  
  # Odd bet
  defp spin_helper(val, game = %{ player_val: "odd" }) do
    result = elem(val, 0)
    |> String.to_integer
    |> Integer.is_odd
    
    game
    |> Map.put(:game_state, result)
    |> Map.put(:table_val, val)
  end

  # Even bet
  defp spin_helper(val, game = %{ player_val: "even"}) do
    result = elem(val, 0)
    |> String.to_integer
    |> Integer.is_even
    
    game
    |> Map.put(:game_state, result)
    |> Map.put(:table_val, val)
  end
  
  # Number bet 
  defp spin_helper(val, game = %{ player_val: num }) do
    result = if elem(val, 0) == num do true else false end
    game
    |> Map.put(:game_state, result)
    |> Map.put(:table_val, val) 
  end

end
