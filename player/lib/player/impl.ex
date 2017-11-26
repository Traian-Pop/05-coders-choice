defmodule Player.Impl do

  def play() do
    IO.puts "-------------------------------------------------------------------------------------------------------------------------------\n"
    IO.puts "Howdy! Welcome to The Wondorous Palace of Elixers, fanciest casino in the wild west. We currently carry Blackjack and Roulette.\n"
    game_name = IO.gets("What kind of game would you like to play today?\n") |> String.downcase |> String.trim
    play(game_name)
  end

  ######## Blackjack UI ########

  def play("blackjack") do
    IO.puts("Here's the Blackjack table. Enjoy!\n")
    #IO.puts("\n")
    Blackjack.new_game()
    |> Blackjack.hit()
    |> get_blackjack_decision()
  end

  defp get_blackjack_decision({ game, state }) do
    IO.puts("Dealer has the cards: ")
    print_cards(:dealer, game.dealer_hand)
    IO.puts("\nYou have the cards: ")
    print_cards(:player, game.player_hand)
    choice = IO.gets("\nWhat would you like to do? (Hit, Stand, Leave)\n") |> String.downcase |> String.trim
    
    case choice do
      "hit" -> 
        Blackjack.Game.hit(game)
        |> get_blackjack_decision()
      #"stand" ->
        #  Blackjack.Game.stand(game)
        #|> get_blackjack_dealer_decision()
      #"leave" ->
      _ ->
        IO.puts("Please enter a valid input.")
        get_blackjack_decision({ game, state })
    end
  end
  
  defp black_get_next_move({game, state}) do
    Blackjack.hit(game)
   |> black_get_next_move
  end

  defp print_cards(:dealer, [_head | tail]) do
    IO.inspect tail
  end

  defp print_cards(:player, hand) do
    IO.inspect hand
  end
  ######## Roulette UI ########
  
  #  def play("roulette") do
  #    roul_get_next_move({game, Roulette.check(game))
  #  end


  # defp roul_get_next_move({game, state}) do
  #   Roulette.spin(game)
  #   |> roul_get_next_move
  # end

  ######## Extra Cases ########

  def play(_game) do
    IO.puts "We don't carry that game partner, come back next time!"
    play()
  end
    
end
