defmodule Blackjack.Game do

  def new_game() do
  %Blackjack.State{
  }
  end
  
  def check(game) do
  %{
    game_state: game.game_state,
    deck_state: game.deck_state,
    dealer_hand: game.dealer_hand,
    player_hand: game.player_hand
  }
  end

  def hit(game) do
    %{ game | deck_state: game.deck_state - 1 }
    |> move()
    |> return_check()
  end

  defp move(game) do
    Map.put(game, :player_hand, game.player_hand + 1)
  end

  defp return_check(game) do
    { game, check(game) }
  end

end
