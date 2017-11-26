defmodule Blackjack.Deck do

  @suits ~w(spades clubs hearts diamonds)
  @nums ~w(A 2 3 4 5 6 7 8 9 10 J Q K)

  def deck(suits \\ @suits, nums \\ @nums) do
    for suit <- suits, num <- nums, do: { suit, num } 
  end 

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def restart() do
    shuffle(deck())
  end

  def deal(deck, num), do: Enum.split(deck, num) 
end
