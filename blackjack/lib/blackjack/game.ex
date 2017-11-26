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
    dealer_value: game.dealer_value,
    player_hand: game.player_hand,
    player_value: game.player_value,
    turn: game.turn
  }
  end

  # New game setup
  def hit(game = %{ game_state: :init }) do
    {[card1, card2, card3, card4], new_deck} = Blackjack.Deck.deal(game.deck_state, 4)
    game
    |> Map.put(:game_state, :ongoing)
    |> Map.put(:player_hand, [card1, card3])
    |> Map.put(:dealer_hand, [card2, card4])
    |> Map.put(:deck_state, new_deck)
    |> return_check()
  end

  # Dealer hit
  def hit(game = %{ turn: :dealer }) do
    {card, new_deck} = Blackjack.Deck.deal(game.deck_state, 1)
    game
    |> Map.put(:dealer_hand, [card | game.dealer_hand])
    |> Map.put(:deck_state, new_deck)
    |> return_check()  
  end

  # Player hit
  def hit(game = %{ turn: :player }) do
    {card, new_deck} = Blackjack.Deck.deal(game.deck_state, 1)
    game
    |> Map.put(:player_hand, [card | game.player_hand])
    |> Map.put(:deck_state, new_deck)
    |> return_check()  
  end

  #Player stand
  def stand(game = %{ turn: :player }) do
    game
    |> Map.put(:turn, :dealer)
    |> return_check()
  end

  # Dealer stand (hand reveal)
  def stand(game = %{ turn: :dealer }) do
    game |>
    Map.put(:game_state, :reveal)
    |> return_check()
  end

  # Update hands
  def count_hands(game) do
    player_val = count_cards(game.player_hand)
    dealer_val = count_cards(game.dealer_hand)
    game
    |> Map.put(:player_value, player_val)
    |> Map.put(:dealer_value, dealer_val)
    |> return_check()
  end

  ######## Private Methods ########
  
  # Returns game state
  defp return_check(game) do
    { game, check(game) }
  end

  # Count value of hand
  defp count_cards(hand) do
    { hand } 
  end

end
