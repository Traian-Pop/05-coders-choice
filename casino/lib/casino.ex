defmodule Casino do
  @name __MODULE__

    def start_link do
      GenServer.start_link( Casino.Server, [], name: @name )
    end

    def new_game(type) do
      GenServer.call(@name, { :new_game, type })
    end
    
end
