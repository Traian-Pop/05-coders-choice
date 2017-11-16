defmodule Casino.Game do
  
  def new_game("blackjack") do
    { Blackjack.new_game() }
  end

end
