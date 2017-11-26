defmodule Blackjack.State do
  
  defstruct(
    game_state: :init,
    deck_state: %{},
    dealer_hand: [],
    dealer_value: 0,
    player_hand: [],
    player_value: 0,
    turn: :player
  )

end
