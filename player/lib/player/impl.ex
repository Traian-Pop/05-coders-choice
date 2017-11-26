defmodule Player.Impl do

  # First time playing
  def play() do
    IO.puts "-------------------------------------------------------------------------------------------------------------------------------\n"
    IO.puts "Howdy! Welcome to The Wondorous Palace of Elixers, fanciest casino in the wild west. We currently carry Blackjack and Roulette.\n"
    game_name = IO.gets("What kind of game would you like to play?\n") |> String.downcase |> String.trim
    play(game_name)
  end

  # Second time playing
  def play(1) do
    IO.puts "\n-------------------------------\n"
    IO.puts "Welcome back to the main floor!\n"
    game_name = IO.gets("What kind of game would you like to play? (Blackjack or Roulette)\n") |> String.downcase |> String.trim
    play(game_name)
  end
 
  ######## Blackjack UI ########

  # Brand new game
  def play("blackjack") do
    IO.puts("Here's the Blackjack table. Enjoy!\n")
    #IO.puts("\n")
    Blackjack.new_game()
    |> Blackjack.hit()
    |> get_blackjack_decision()
  end

  # Second or more game
  def play("blackjack", _1) do
    IO.puts("Ready for another round?\n")
    IO.puts("------------------------\n")
    Blackjack.new_game()
    |> Blackjack.hit()
    |> get_blackjack_decision()
  end

  # General method for normal game function for player
  defp get_blackjack_decision({ game, state = %{ game_state: :ongoing, turn: :player }}) do
    IO.puts("\nDealer has the cards: ")
    print_cards(:dealer, state.dealer_hand)
    IO.puts("\nYou have the cards: ")
    print_cards(:player, state.player_hand)
    choice = IO.gets("\nWhat would you like to do? (Hit, Stand, Leave)\n") |> String.downcase |> String.trim
    
    case choice do
      "hit" -> 
        Blackjack.Game.hit(game)
        |> get_blackjack_decision()
      "stand" ->
        Blackjack.Game.stand(game)
        |> get_blackjack_decision()
      "leave" ->
        IO.puts("Leaving so soon?\n")
        play(1)
      _ ->
        IO.puts("Please enter a valid input.\n")
        get_blackjack_decision({ game, state })
    end
  end

  # General method for normal game function for dealer
  defp get_blackjack_decision({ game, state = %{ game_state: :ongoing, turn: :dealer} }) do
    IO.puts("\nDealer has the cards: ")
    print_cards(:player, state.dealer_hand)
    Blackjack.Game.hit(game)
    |> get_blackjack_decision()
  end

  # Reveal
  defp get_blackjack_decision({ _game, _state = %{ game_state: :reveal }}) do
    IO.puts("\nAnd the result is...\n")
    play("blackjack", 1)
  end

  # Player wins
  defp get_blackjack_decision({ _game, _state = %{ game_state: :player_won }}) do
    IO.puts("\n...the player wins!\n")
    play("blackjack", 1)
  end
  
  # House wins
  defp get_blackjack_decision({ _game, _state = %{ game_state: :house_won }}) do
    IO.puts("\n...the house wins!\n")
    play("blackjack", 1)
  end

  # Tie game 
  defp get_blackjack_decision({ _game, _state = %{ game_state: :tie }}) do
    IO.puts("\n...a tie!\n")
    play("blackjack", 1)
  end

  #Player busts
  defp get_blackjack_decision({ _game, _state = %{ game_state: :player_bust }}) do
    IO.puts("\n...the player busts!\n")
    play("blackjack", 1)
  end

  #House busts
  defp get_blackjack_decision({ _game, _state = %{ game_state: :house_bust }}) do
    IO.puts("\n...the house busts!\n")
    play("blackjack", 1)
  end
  
  # Print Cards for player to see
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

  # Error case
  def play(_game) do
    IO.puts "We don't carry that game partner, come back next time!"
    play(1)
  end
    
end
