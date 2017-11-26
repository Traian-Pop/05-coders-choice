defmodule BlackjackTest do
  use ExUnit.Case
  doctest Blackjack

  test "new game" do
    game = Blackjack.Game.new_game()
    game = Blackjack.Game.hit(game)
    
    assert elem(game, 0).player_value <= 21
    assert elem(game, 0).dealer_value <= 21
    assert Enum.count(elem(game, 0).dealer_hand) == 2
    assert Enum.count(elem(game, 0).player_hand) == 2
  end

  test "hit" do
    game = Blackjack.Game.new_game()
    game = Blackjack.Game.hit(game)
    game = Blackjack.Game.hit(elem(game, 0))

    assert elem(game, 0).dealer_value <= 21
    assert Enum.count(elem(game, 0).dealer_hand) == 2
    assert Enum.count(elem(game, 0).player_hand) == 3
  end

  test "dealer hit // player stands" do
   
    game = Blackjack.Game.new_game()
    |> Map.put(:player_hand, [{"spades", "A"}, {"spades", "10"}])
    |> Map.put(:dealer_hand, [{"spades", "2"}, {"spades", "3"}])
    |> Map.put(:player_value, 21)
    |> Map.put(:dealer_value, 5)
    |> Map.put(:game_state, :ongoing)
    game = Blackjack.Game.stand(game)
    game = Blackjack.Game.hit(elem(game, 0))

    assert Enum.count(elem(game, 0).dealer_hand) == 3
    assert Enum.count(elem(game, 0).player_hand) == 2
  end

  test "dealer stands" do
    game = Blackjack.Game.new_game()
    |> Map.put(:dealer_hand, [{"spades", "A"}, {"spades", "10"}])
    |> Map.put(:player_hand, [{"spades", "2"}, {"spades", "3"}])
    |> Map.put(:dealer_value, 21)
    |> Map.put(:player_value, 5)
    |> Map.put(:game_state, :ongoing)
    game = Blackjack.Game.stand(game)
    game = Blackjack.Game.hit(elem(game, 0))

    assert Enum.count(elem(game, 0).dealer_hand) == 2
    assert Enum.count(elem(game, 0).player_hand) == 2
  end

  test "house bust" do 
    game = Blackjack.Game.new_game()
    |> Map.put(:player_hand, [{"spades", "A"}, {"spades", "10"}])
    |> Map.put(:dealer_hand, [{"spades", "10"}, {"spades", "J"}, {"spades", "Q"}])
    |> Map.put(:player_value, 21)
    |> Map.put(:dealer_value, 30)
    |> Map.put(:game_state, :ongoing)
    game = Blackjack.Game.stand(game)
    game = Blackjack.Game.hit(elem(game, 0))

    assert elem(game, 0).game_state == :house_bust
  end

  test "lose" do 
    game = Blackjack.Game.new_game()
    |> Map.put(:dealer_hand, [{"spades", "A"}, {"spades", "10"}])
    |> Map.put(:player_hand, [{"spades", "2"}, {"spades", "3"}])
    |> Map.put(:dealer_value, 21)
    |> Map.put(:player_value, 5)
    |> Map.put(:game_state, :ongoing)
    game = Blackjack.Game.stand(game)
    game = Blackjack.Game.hit(elem(game, 0))

    assert elem(game, 0).game_state == :house_won
  end
  
  test "tie" do
    game = Blackjack.Game.new_game()
    |> Map.put(:dealer_hand, [{"spades", "A"}, {"spades", "10"}])
    |> Map.put(:player_hand, [{"hearts", "A"}, {"hearts", "10"}])
    |> Map.put(:dealer_value, 21)
    |> Map.put(:player_value, 21)
    |> Map.put(:game_state, :ongoing)
    game = Blackjack.Game.stand(game)
    game = Blackjack.Game.hit(elem(game, 0))

    assert elem(game, 0).game_state == :tie
  end

  test "player_bust" do 
    game = Blackjack.Game.new_game()
    |> Map.put(:dealer_hand, [{"spades", "A"}, {"spades", "10"}])
    |> Map.put(:player_hand, [{"spades", "J"}, {"spades", "Q"}, {"spades", "K"}])
    |> Map.put(:dealer_value, 21)
    |> Map.put(:player_value, 30)
    |> Map.put(:game_state, :ongoing)
    game = Blackjack.Game.stand(game)
    game = Blackjack.Game.hit(elem(game, 0))

    assert elem(game, 0).game_state == :player_bust
  end
end
