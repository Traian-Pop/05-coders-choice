defmodule Casino.Server do
  
    use GenServer

    def init(default \\ []) do
      { :ok, default }
    end

    def handle_call({ :new_game, word }, _from, state ) do
      { :reply, Casino.Game.new_game(word), state }
    end
    
end
