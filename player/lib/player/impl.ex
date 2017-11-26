defmodule Player.Impl do

  # First time playing
  def play() do
    clear_screen()
    IO.puts "--------------------------------------------------------------------------\n"
    IO.puts "Howdy! Welcome to The Wondorous Palace of Elixers, fanciest casino in the wild west. We currently carry Blackjack and Roulette.\n"
    game_name = IO.gets("What kind of game would you like to play? (Or type Quit to leave)\n") |> String.downcase |> String.trim
    play(game_name)
  end

  # Second time playing
  def play(1) do
    clear_screen()
    IO.puts "--------------------------------------------------------------------------\n"
    IO.puts "Welcome back to the main floor!\n"
    game_name = IO.gets("What kind of game would you like to play? (Blackjack or Roulette or Type Quit to leave)\n") |> String.downcase |> String.trim
    play(game_name)
  end

  # Quit function
  def play("quit") do
    IO.puts "-------------------------------------------------------------------------\n"
    IO.puts "See ya'll next time!\n"
  end

  # Brand new game of blackjack
  def play("blackjack") do
    clear_screen()
    IO.puts("Here's the Blackjack table. Enjoy!\n")
    start_blackjack("yes")
  end

  # Brand new game of roulette
  def play("roulette") do
    clear_screen()
    IO.puts("Here's the Roulette table. Enjoy!\n")
    start_roulette("yes")
  end
  
  # Second or more game of blackjack
  def play("blackjack", _1) do
    IO.gets("Ready for another round? (Yes or No)\n")
    |> String.downcase
    |> String.trim
    |> start_blackjack
  end

  # Second or more game of roulette
  def play("roulette", _1) do
    IO.gets("Ready for another spin? (Yes or No)\n")
    |> String.downcase
    |> String.trim
    |> start_roulette
  end

  ################ Blackjack ################

  # Method that actually starts game
  defp start_blackjack("yes") do
    clear_screen()
    Blackjack.Game.new_game
    |> Blackjack.Game.hit
    |> get_blackjack_decision
  end

  # Leave choice
  defp start_blackjack("no") do
    IO.puts("Leaving so soon?\n")
    play(1)
  end

  # Error choice
  defp start_blackjack(_choice) do
    IO.puts("Not sure I understood you there")
    play("blackjack", 1)
  end

  # General method for normal game function for player
  defp get_blackjack_decision({ game, state = %{ game_state: :ongoing, turn: :player }}) do
    IO.puts("\nDealer has the cards: ")
    print_cards(:dealer, state.dealer_hand)
    IO.puts("\nYou have the cards: ")
    print_cards(:player, state.player_hand)
    IO.gets("\nWhat would you like to do? (Hit, Stand, Leave)\n") 
    |> String.downcase 
    |> String.trim
    |> get_blackjack_choice(game, state)
  end

  # General method for normal game function for dealer
  defp get_blackjack_decision({ game, state = %{ game_state: :ongoing, turn: :dealer } }) do
    IO.puts("\nDealer has the cards: ")
    print_cards(:player, state.dealer_hand)
    Blackjack.Game.hit(game)
    |> get_blackjack_decision()
  end

  # Reveal
  defp get_blackjack_decision({ _game, _state = %{ game_state: :reveal } }) do
    IO.puts("\nAnd the result is...\n")
    play("blackjack", 1)
  end

  # Player wins
  defp get_blackjack_decision({ _game, _state = %{ game_state: :player_won } }) do
    IO.puts("\n...the player wins!\n")
    play("blackjack", 1)
  end
  
  # House wins
  defp get_blackjack_decision({ _game, _state = %{ game_state: :house_won } }) do
    IO.puts("\n...the house wins!\n")
    play("blackjack", 1)
  end

  # Tie game 
  defp get_blackjack_decision({ _game, _state = %{ game_state: :tie } }) do
    IO.puts("\n...a tie!\n")
    play("blackjack", 1)
  end

  #Player busts
  defp get_blackjack_decision({ _game, _state = %{ game_state: :player_bust } }) do
    IO.puts("\n...the player busts!\n")
    play("blackjack", 1)
  end

  #House busts
  defp get_blackjack_decision({ _game, _state = %{ game_state: :house_bust } }) do
    IO.puts("\n...the house busts!\n")
    play("blackjack", 1)
  end
  
  #helper methods for choice

  defp get_blackjack_choice("hit", game, _state) do
    Blackjack.Game.hit(game)
    |> get_blackjack_decision()
  end

  defp get_blackjack_choice("stand", game, _state) do
    Blackjack.Game.stand(game)
    |> get_blackjack_decision()
  end

  defp get_blackjack_choice("leave", _game, _state) do
    IO.puts("Leaving so soon?\n")
    play(1)
  end
  
  defp get_blackjack_choice(_choice, game, state) do
    IO.puts("Please enter a valid input.\n")
    get_blackjack_decision({ game, state })
  end

  # Print Cards for player to see
  defp print_cards(:dealer, [_head | tail]) do
    IO.inspect tail
  end

  defp print_cards(:player, hand) do
    IO.inspect hand
  end

  ##########################################
  ################ Roulette ################
  ##########################################

  # Method that actually starts game
  defp start_roulette("yes") do
    clear_screen()
    Roulette.new_game
    |> get_roulette_decision
  end

  # Leave choice
  defp start_roulette("no") do
    IO.puts("Leaving so soon?\n")
    play(1)
  end

  # Error choice
  defp start_roulette(_choice) do
    IO.puts("Not sure I understood you there")
    play("roulette", 1)
  end

  # General method for normal game function for player
  defp get_roulette_decision({ game, _state = %{ game_state: :init}}) do
    IO.gets("\nWhat bet would you like to make? (Red, Black, Odd, Even, or a number 0-36) \n") 
    |> String.downcase 
    |> String.trim
    |> Roulette.spin(game)
    |> print_spin
    |> get_roulette_decision
  end
  
  # Player wins Red
  defp get_roulette_decision({ _game, _state = %{ game_state: true, player_val: "red" } }) do
    IO.puts("\n...the player guesses red numbres correctly!\n")
    play("roulette", 1)
  end
  
  # Player wins Black
  defp get_roulette_decision({ _game, _state = %{ game_state: true, player_val: "black" } }) do
    IO.puts("\n...the player guesses black numbers correctly!\n")
    play("roulette", 1)
  end

  # Player wins Odd
  defp get_roulette_decision({ _game, _state = %{ game_state: true, player_val: "odd" } }) do
    IO.puts("\n...the player guesses odd numbers correctly!\n")
    play("roulette", 1)
  end
  
  # Player wins Even
  defp get_roulette_decision({ _game, _state = %{ game_state: true, player_val: "even" } }) do
    IO.puts("\n...the player guesses even numbers correctly!\n")
    play("roulette", 1)
  end

  # Player wins Number
  defp get_roulette_decision({ _game, _state = %{ game_state: true } }) do
    IO.puts("\n...the player guessed the exact number correctly!!!!!\n")
    play("roulette", 1)
  end

  # Player loses
  defp get_roulette_decision({_game, _state = %{ game_state: false } }) do
    IO.puts("\n...the house wins!\n")
    play("roulette", 1)
  end

  defp print_spin({ game, state }) do
    IO.inspect state.table_val
    { game, state }
  end

  ######## Extra Cases ########
  
  # Error case
  def play(_game) do
    IO.puts "We don't carry that game partner, come back next time!"
    play(1)
  end

  # Clear function
  defp clear_screen(), do: IO.write "\e[H\e[2J"
    
end
