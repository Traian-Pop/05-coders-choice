defmodule DeckTest do
  use ExUnit.Case
  doctest Deck

  test "make deck" do
    deck = Deck.deck()

    assert 1 == Enum.count(deck, &(&1 == {"spades", "A"}))
    assert 1 == Enum.count(deck, &(&1 == {"clubs", "2"}))
    assert 1 == Enum.count(deck, &(&1 == {"hearts", "3"}))
    assert 1 == Enum.count(deck, &(&1 == {"diamonds", "4"}))
  end

  test "shuffle correctly" do
    deck1 = Deck.deck()
    deck2 = Deck.shuffle()

    assert deck1 != deck2
  end

  test "deal correctly" do
    deck = Deck.shuffle()
    {card, deck} = Deck.deal(deck, 1)
    assert Enum.count(deck) == 51
    assert Enum.count(card) == 1 
  end

end
