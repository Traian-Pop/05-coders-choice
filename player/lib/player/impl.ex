defmodule Player.Impl do

  def play() do
    play(Casino.new_game("blackjack"))
  end

  def play(game) do
    get_next_move({game, Blackjack.check(game)})
  end

  defp get_next_move({game, state}) do
    Blackjack.hit(game)
    |> get_next_move
  end

end
