defmodule Table.Impl do

  @numbers ~w(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 0 00)
  @colors ~w(r b r b r b r b r b b r b r b r b r r b r b r b r b r b b r b r b r b r g g) 
  @spinner Enum.zip(@numbers, @colors)  
  
  def spin(), do: Enum.shuffle(@spinner) |> Enum.at(0)

  def spinner(), do: @spinner
end
