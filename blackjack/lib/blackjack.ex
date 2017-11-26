defmodule Blackjack do

  @name __MODULE__
  
  def start_link() do
    GenServer.start_link( Blackjack.Server, [], name: @name )
  end

  def new_game() do
    GenServer.call(@name, { :new_game })
  end
  
  def check(game) do
    GenServer.call(@name, { :check, game })
  end

  def hit(game) do
    GenServer.call(@name, { :hit, game })
  end

end
