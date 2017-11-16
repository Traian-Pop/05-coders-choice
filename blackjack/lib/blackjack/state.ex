defmodule Blackjack.State do
  
  defstruct(
    game_state: :initializing,
    dealer_hand: 0,
    player_hand: 0
  )

end
