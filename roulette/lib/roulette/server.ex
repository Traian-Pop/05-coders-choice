defmodule Roulette.Server do

  use GenServer

  def init(default \\ []) do
    { :ok, default }
  end

  def handle_call({ :new_game }, _from, state ) do
    { :reply, Roulette.Game.new_game(), state }
  end

  def handle_call({ :check, game }, _from, state ) do
    { :reply, Roulette.Game.check(game), state }
  end

  def handle_call({ :spin, bet, game }, _from, state ) do
    { :reply, Roulette.Game.spin(bet, game), state }
  end
end
