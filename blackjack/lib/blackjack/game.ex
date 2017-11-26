defmodule Blackjack.Game do

  # New game method
  def new_game() do
    %Blackjack.State{}
      |> Map.put(:deck_state, Deck.shuffle())
  end

  # State  
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
    {[card1, card2, card3, card4], new_deck} = Deck.deal(game.deck_state, 4)
    game
    |> Map.put(:game_state, :ongoing)
    |> Map.put(:player_hand, [card1, card3])
    |> Map.put(:dealer_hand, [card2, card4])
    |> Map.put(:deck_state, new_deck)
    |> count_hands()
    |> return_check()
  end

  # Dealer hit
  def hit(game = %{ turn: :dealer }) do
    dealer(game, game.dealer_value, game.player_value)
  end

  # Player hit
  def hit(game = %{ turn: :player }) do
    {card, new_deck} = Deck.deal(game.deck_state, 1)
    game
    |> Map.put(:player_hand, card ++ game.player_hand)
    |> Map.put(:deck_state, new_deck)
    |> count_hands()
    |> return_check()  
  end

  #Player stand
  def stand(game = %{ turn: :player }) do
    game
    |> Map.put(:turn, :dealer)
    |> return_check()
  end

  ######## Private Methods ########
  
  # Returns game state
  defp return_check(game) do
    { game, check(game) }
  end

  # Dealer helper function
  defp dealer(game, dealer_val, player_val) do
    case dealer_val do
      _ when player_val > 21 ->
        dealer_stand(game)
      dealer_val when dealer_val < player_val and dealer_val <= 21 ->
        dealer_hit(game)
      dealer_val when dealer_val > player_val ->
        dealer_stand(game)
      dealer_val when dealer_val == player_val ->
        dealer_stand(game)
    end
  end

  # Dealer hit
  defp dealer_hit(game) do
    {card, new_deck} = Deck.deal(game.deck_state, 1)
    game
    |> Map.put(:dealer_hand, card ++ game.dealer_hand)
    |> Map.put(:deck_state, new_deck)
    |> count_hands()
    |> return_check()  
  end

  #Dealer stands
  defp dealer_stand(game) do
    game |>
    Map.put(:game_state, :reveal)
    |> evaluate_result(game.dealer_value, game.player_value)
    |> return_check()
  end

  # Update hands
  defp count_hands(game) do
    player_val = count_cards(game.player_hand, 0, 0)
    dealer_val = count_cards(game.dealer_hand, 0, 0)
    game
    |> Map.put(:player_value, player_val)
    |> Map.put(:dealer_value, dealer_val)
  end
  
  #Return function
  defp count_cards([], total, _ace=0) do
    total
  end

  # Count value of hand
  defp count_cards([head | tail], total, ace) do
    face = is_face(head)

    case head do
      { _ , "A" } ->
        count_cards(tail, total, ace + 1)
      _ when face ->
        count_cards(tail, total + 10, ace)
      _ ->
        count_cards(tail, total + String.to_integer(elem(head, 1)), ace)
    end
  end

  #Special ace rule 1
  defp count_cards([], total, ace) when total + 11 <= 21 do
    count_cards([], total + 11, ace - 1) 
  end

  #Special ace rule 2
  defp count_cards([], total, ace) when total + 11 > 21 do
    count_cards([], total + 1, ace - 1)
  end

  # Sees if card is a face card
  defp is_face({_, val}), do: String.contains?("JQK", val)
  
  # Evaluate end result of game when dealer stands
  defp evaluate_result(game = %{ game_state: :reveal }, dealer_val, player_val) do
    case game do
      _ when player_val > 21 ->
        %{ game | game_state: :player_bust }
      _ when dealer_val > 21 ->
        %{ game | game_state: :house_bust }
      _ when dealer_val == player_val ->
        %{ game | game_state: :tie }
      _ when player_val > dealer_val ->
        %{ game | game_state: :player_won }
      _ when dealer_val > player_val ->
        %{ game | game_state: :house_won }
    end
  end
end
