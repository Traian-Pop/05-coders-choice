defmodule Roulette do

  @name __MODULE__

  def start_link() do
    GenServer.start_link( Roulette.Server, [], name: @name )
  end

  def new_game() do
    GenServer.call(@name, { :new_game })
  end

  def check(game) do
    GenServer.call(@name, { :check, game })
  end

  def spin(bet, game) do
    GenServer.call(@name, { :spin, bet, game })
  end

end
