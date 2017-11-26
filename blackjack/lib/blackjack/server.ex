defmodule Blackjack.Server do
  
  use GenServer

  def init(default \\ []) do
    {:ok, default }
  end

  def handle_call({ :new_game }, _from, state ) do
    { :reply, Blackjack.Game.new_game(), state }
  end

  def handle_call({ :check, game }, _from, state ) do
    { :reply, Blackjack.Game.check(game), state }
  end

  def handle_call({ :hit, game }, _from, state ) do
    { :reply, Blackjack.Game.hit(game), state }
  end

end
