defmodule Casino.State do

    # house_percent: percent of hands the dealer has won
    # house_net: net amount of money the house has won (negative means losing)
  
     defstruct(
      game_state: :initializing,
      house_percent: 0,
      house_net: 0
     )
end
